#  deploy ec2 instance

# add something to tag the vms lmfao


data "aws_ami" "ami" {
  most_recent = true

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
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
}





