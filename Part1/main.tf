#  deploy ec2 instance

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name = "name"
    values = [ "amazon/amzn2-ami-hvm-*-gp2" ]
  }

  filter {
   name = "virtualization-type"
   values = ["hvm"]
  }

  owners = [ "137112412989" ]
}

resource "aws_instance" "webserver" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  count = var.instance_count
  availability_zone = var.az[0]
  associate_public_ip_address = true
  

  tags = {
    Name = var.name
  }
}





