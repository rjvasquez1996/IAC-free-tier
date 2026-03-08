# All resources in this file are only created when run_on_ecs = true

# IAM role allowing EC2 instances to register as ECS container instances
resource "aws_iam_role" "ecs_instance" {
  count = var.run_on_ecs ? 1 : 0
  name  = "ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance" {
  count      = var.run_on_ecs ? 1 : 0
  role       = aws_iam_role.ecs_instance[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance" {
  count = var.run_on_ecs ? 1 : 0
  name  = "ecs-instance-profile"
  role  = aws_iam_role.ecs_instance[0].name
}

resource "aws_ecs_cluster" "main" {
  count = var.run_on_ecs ? 1 : 0
  name  = "memos-cluster"
}

# EC2 instance acting as the ECS container instance
resource "aws_instance" "ecs_container_instance" {
  count                  = var.run_on_ecs ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ecs_instance[0].name

  user_data = <<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.main[0].name} >> /etc/ecs/ecs.config
  EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "ecs-container-instance"
  }
}

resource "aws_ecs_task_definition" "memos" {
  count        = var.run_on_ecs ? 1 : 0
  family       = "memos"
  network_mode = "bridge"

  container_definitions = jsonencode([{
    name      = "memos"
    image     = "neosmemo/memos:stable"
    essential = true
    memory    = 512
    cpu       = 256
    portMappings = [{
      containerPort = 5230
      hostPort      = 5230
      protocol      = "tcp"
    }]
    mountPoints = [{
      sourceVolume  = "memos-data"
      containerPath = "/var/opt/memos"
    }]
  }])

  volume {
    name      = "memos-data"
    host_path = "/var/opt/memos"
  }
}

resource "aws_ecs_service" "memos" {
  count           = var.run_on_ecs ? 1 : 0
  name            = "memos"
  cluster         = aws_ecs_cluster.main[0].id
  task_definition = aws_ecs_task_definition.memos[0].arn
  desired_count   = 1
  launch_type     = "EC2"

  depends_on = [aws_instance.ecs_container_instance]
}
