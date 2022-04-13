data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allows HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "all HTTP inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "ALL outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg-lab3"
  }
}