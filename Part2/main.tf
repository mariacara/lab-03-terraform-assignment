provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

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

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ami.image_id
  instance_type               = var.instance_type
  availability_zone           = var.az[0]
  key_name                    = "mc-lab3"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.web-sg.id}"]
  tags                        = merge(var.project_tags)

}

resource "null_resource" "copyfile" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./mc-lab3.pem")
    host        = aws_instance.web.public_ip
  }

  # copy the ansible playbook using provisioner

  provisioner "file" {
    source      = "./webserver.yml"
    destination = "/tmp/webserver.yml"
  }

  depends_on = [aws_instance.web]

  # install ansible using remote provisioner

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
    ]
  }

  # run ansible playbook command using remote provisioner

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook /tmp/webserver.yml",
    ]

  }
}

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow ssh and http inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow ssh and http inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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