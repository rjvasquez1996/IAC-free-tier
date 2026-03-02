# Security group — allows SSH from your current public IP and all outbound traffic
resource "aws_security_group" "ec2_sg" {
  name        = "free-tier-ec2-sg"
  description = "Allow SSH inbound, all outbound"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Free-tier eligible EC2 instance (t2.micro, 750 hrs/month for 12 months)
resource "aws_instance" "free_tier" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # 30 GB is the free-tier limit for EBS gp3 storage
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "free-tier-ec2"
  }
}
