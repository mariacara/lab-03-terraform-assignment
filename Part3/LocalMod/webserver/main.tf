variable "sg" {}

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
  ami                         = data.aws_ami.ami.id
  instance_type               = var.instance_type
  availability_zone           = var.az[0]
  vpc_security_group_ids      = [var.sg.id]
  key_name                    = "mc-lab3"
  associate_public_ip_address = true
  tags                        = merge(var.project_tags)
  user_data                   = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              echo "<html><body><h1>Hello from $(hostname -f)</h1><h2>MC-WebServer 1</h2></body></html>" > /var/www/html/index.html
              sudo systemctl restart httpd
              sudo systemctl enable httpd
              EOF
}

