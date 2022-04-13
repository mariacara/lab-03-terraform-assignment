variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "instance_count" {
  description = "EC2 instance count - default is 1"
  type        = number
  default     = 1
}

variable "public_ip" {
  type    = bool
  default = true
}

variable "project_tags" {
  type = map(string)
  default = {
    Name  = "vm1"
    Owner = "Maria Carapaica"
  }
}
