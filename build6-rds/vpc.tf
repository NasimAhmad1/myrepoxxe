resource "aws_vpc" "myvpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public_subnet-1" {
  vpc_id = aws_vpc.myvpc1.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet-1"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id = aws_vpc.myvpc1.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true" 
  availability_zone = "us-east-1b"
  tags = {
    Name = "public_subnet-2"
  }
}

resource "aws_subnet" "public_subnet-3" {
   vpc_id = aws_vpc.myvpc1.id
   cidr_block = "10.0.3.0/24"
   map_public_ip_on_launch = "true"
   availability_zone = "us-east-1c"
   tags = {
     Name = "public_subnet-3"
   } 
}


#Private Subnet
resource "aws_subnet" "private_subnet-1" {
  vpc_id = aws_vpc.myvpc1.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private_subnet-1"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id = aws_vpc.myvpc1.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private_subnet-2"
  }
}

resource "aws_subnet" "private_subnet-3" {
  vpc_id = aws_vpc.myvpc1.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private_subnet-3"
  }
}


# Create Internet Gateway

resource "aws_internet_gateway" "custome-gw" {
    vpc_id = aws_vpc.myvpc1.id

    tags = {
      Name = "custom-gw"
    }
}

# Create Route Table

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.myvpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.custome-gw.id
    }
  
    tags = {
      Name = "public_route"
    }
}

# Associate route with subnet

resource "aws_route_table_association" "public_route-1a" {
  subnet_id = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_route-1b" {
  subnet_id = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_route-1c" {
  subnet_id = aws_subnet.public_subnet-3.id
  route_table_id = aws_route_table.public_route.id
}

