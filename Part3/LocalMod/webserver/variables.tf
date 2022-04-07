variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"  
}

variable "az" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "instance_count" {
    description = "EC2 instance count - default is 1"
    type = number
    default = 1
}