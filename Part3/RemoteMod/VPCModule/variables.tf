variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "cidr block of the vpc"
  default     = "100.64.0.0/16"
}

variable "public_cidr" {
  description = "cidr block of public subnet"
  type        = list(string)
  default     = ["100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24", "100.64.4.0/24"]
}

variable "public_ip" {
  type    = bool
  default = true
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "project_tags" {
  type = map(string)
  default = {
    Name  = "mc-vpc"
    Owner = "Maria Carapaica"
  }
}