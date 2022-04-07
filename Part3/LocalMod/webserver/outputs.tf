output "web_public_ip" {
  description = "Public IP address of the EC2 instance to access webserver"
  value       = "http://${aws_instance.app_server.public_ip}"
}
