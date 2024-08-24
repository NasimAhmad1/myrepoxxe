resource "aws_vpc" "project-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "project-VPC"
    }
}

resource "aws_subnet" "private-subnet1" {
    vpc_id = aws_vpc.project-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Private-subnet-1a"
    }
}
resource "aws_subnet" "private-subnet2" {
    vpc_id = aws_vpc.project-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Private-subnet-1b"
    }
}
resource "aws_subnet" "public-subnet1" {
    vpc_id = aws_vpc.project-vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public-subnet-1a"
    }
}
resource "aws_subnet" "Public-subnet2" {
    vpc_id = aws_vpc.project-vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Private-subnet-1b"
    }
}

resource "aws_internet_gateway" "project-gw" {
    vpc_id = aws_vpc.project-vpc.id
  
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-gw.id
  }
  
}

resource "aws_route_table_association" "subnet-association" {
    subnet_id = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.public-route.id
}
