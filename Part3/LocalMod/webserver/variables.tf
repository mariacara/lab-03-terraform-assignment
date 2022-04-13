variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "project_tags" {
  type = map(string)
  default = {
    Name  = "web1"
    Owner = "Maria Carapaica"
  }
}