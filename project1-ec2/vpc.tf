resource "aws_vpc" "project1" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    tags = {
        Name = "project1"

    }
  
}

resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.project1.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
      Name = "public-subnet"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.project1.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
      Name = "public-subnet2"
    }
  
}

resource "aws_subnet" "private-subnet1" {
    vpc_id = aws_vpc.project1.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-east-1a"
    tags = {
      Name = "private_subnet1"
    }
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.project1.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet2"
    }
}

resource "aws_internet_gateway" "projet1-gw" {
    vpc_id = aws_vpc.project1.id
    tags = {
        Name = "project1-gw"
    }
}

resource "aws_route_table" "public_route1" {
  vpc_id = aws_vpc.project1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.projet1-gw.id
  } 
}

resource "aws_route_table_association" "public-route-1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route1.id
  
}

resource "aws_route_table_association" "public_route2" {
  route_table_id = aws_route_table.public_route1.id
  subnet_id = aws_subnet.public_subnet2.id
  
}