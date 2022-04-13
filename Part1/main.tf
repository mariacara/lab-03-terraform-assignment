# This script deploys an AWS EC2 instance

# Selects the most recent AWS AMI image to use
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "webserver" {
  ami                         = data.aws_ami.ami.image_id
  instance_type               = var.instance_type
  count                       = var.instance_count
  availability_zone           = var.az[0]
  associate_public_ip_address = var.public_ip
  tags                        = merge(var.project_tags)
}





