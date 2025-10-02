# Key pair (for login)
resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-infra-app-key"
  # public_key = file("terra-key-ec2.pub")
   public_key = file("${path.module}/terra-key-ec2.pub")
}

# Default VPC
resource "aws_default_vpc" "default_vpc" {}

# Security group
resource "aws_security_group" "my_sg" {
  name   = "${var.env}-infra-app-sg"
  vpc_id = aws_default_vpc.default_vpc.id

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outgoing traffic"
  }

  tags = {
    Name = "${var.env}-infra-app-sg"
  }
}

# EC2 instance
resource "aws_instance" "ubuntu" {
  count = var.instance_count

  depends_on = [aws_security_group.my_sg, aws_key_pair.my_key]

  ami                    = var.ec2_ami_id # Ubuntu in ap-south-1
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_size = var.env == "prod" ? 10 : 8
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.env}-infra-app-instance"
    Environment = var.env
  }
}
