# Security group — allows SSH from your current public IP and all outbound traffic
resource "aws_security_group" "ec2_sg" {
  name        = "free-tier-ec2-sg"
  description = "Allow SSH inbound, all outbound"

  ingress {
    description = "port "
    from_port   = 5230
    to_port     = 5230
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = local.ssh_cidrs
}

# Free-tier eligible EC2 instance (t2.micro, 750 hrs/month for 12 months)
resource "aws_instance" "free_tier" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("${path.module}/user_data.sh")

  # 30 GB is the free-tier limit for EBS gp2 storage
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "free-tier-ec2"
  }
}
