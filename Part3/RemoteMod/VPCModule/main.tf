# This Script creates a VPC
resource "aws_vpc" "mc-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.project_tags)
}

# create the public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_cidr)
  cidr_block              = var.public_cidr[count.index]
  vpc_id                  = aws_vpc.mc-vpc.id
  map_public_ip_on_launch = var.public_ip
  availability_zone       = var.az[count.index]
}

#create the internet gateway for public subnets
resource "aws_internet_gateway" "mc_igw" {
  vpc_id = aws_vpc.mc-vpc.id
  tags = {
    Name = "mc-igw"
  }
}

# create
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mc-vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mc_igw.id
}

# associate public subnets to route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public-.*.id[count.index] # the * associates every public subnet to route table
  route_table_id = aws_route_table.public_rt.id
}

