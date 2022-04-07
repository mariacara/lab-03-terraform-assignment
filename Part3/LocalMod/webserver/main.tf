resource "aws_instance" "webserver" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  count = var.instance_count
  availability_zone = var.az[0]
  associate_public_ip_address = true
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              echo "Hello from $(hostname -f)" > /var/www/html/index.html
              sudo systemctl restart httpd
              sudo systemctl enable httpd
              EOF
}

