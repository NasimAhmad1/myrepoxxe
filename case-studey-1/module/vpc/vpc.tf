data "aws_availability_zones" "available" {
   state = "available"  
}

## VPC Create

resource "aws_vpc" "levelup-vpc" {
  cidr_block = var.LEVELUP_VPC_CIDR_BLOCK
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    name = "${var.ENVIRONMENT}-vpc"
  }
}

#Public Subnet 1

resource "aws_subnet" "levelup_vpc_public_subnet-1" {
    vpc_id = aws_vpc.levelup-vpc.id
    cidr_block = var.LVELUPVPC_PUBLIC_SUBNET-1_CIDR_BLOCK
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
      name = "${var.ENVIRONMENT}-public-subnet-1"
    }
  
}

# Public Subnet 2

resource "aws_subnet" "levelup_vpc_public_subnet-2" {
    vpc_id = aws_vpc.levelup-vpc.id
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    cidr_block = var.LVELUPVPC_PUBLIC_SUBNET-2_CIDR_BLOCK
    tags = {
      name = "{var.ENVIRONMENT}-public-subnet-2"
    }
  
}

# Private Subnet

resource "aws_subnet" "levelup_vpc_private_subnet-1" {
    vpc_id = aws_vpc.levelup-vpc.id
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
    cidr_block = var.LVELUPVPC_PRIVATE_SUBNET-1_CIDR_BLOCK
    tags = {
      name = "{var.ENVIRONMENT}-private-subnet-1"
    }
  
}

resource "aws_subnet" "levelup_vpc_private_subnet-2" {
    vpc_id = aws_vpc.levelup-vpc.id
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    cidr_block = var.LVELUPVPC_PRIVATE_SUBNET-2_CIDR_BLOCK
    tags = {
      name = "{var.ENVIRONMENT}-private-subnet-2"
    }
  
}

# Internet Gateway

resource "aws_internet_gateway" "levelup-gateway" {
    vpc_id = aws_vpc.levelup-vpc.id
    tags = {
        name = "${var.ENVIRONMENT}-Gateway"
    }
      
       
}


# Elastic IP

resource "aws_eip" "levelup-eip" {
    depends_on = [ aws_internet_gateway.levelup-gateway ]
  
}


# NAT gateway for Private IP

resource "aws_nat_gateway" "levelup-ngw" {
    allocation_id = aws_eip.levelup-eip.id
    subnet_id = aws_subnet.levelup_vpc_public_subnet-1.id
    depends_on = [ aws_internet_gateway.levelup-gateway ]
    tags = {
      name = var.ENVIRONMENT
    }
  
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.levelup-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup-gateway.id
  }
}

#Route Table for Private Subnet

resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.levelup-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.levelup-gateway.id
    }
  
}

# Associate Subnet with Route
resource "aws_route_table_association" "public_subnet-1" {
  subnet_id = aws_subnet.levelup_vpc_public_subnet-1
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet-2" {
  subnet_id = aws_subnet.levelup_vpc_public_subnet-2.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private-subnet-1" {
    subnet_id = aws_subnet.levelup_vpc_private_subnet-1.id
    route_table_id = aws_route_table.private_route
  
}

resource "aws_route_table_association" "private_subnet-2" {
    subnet_id = aws_subnet.levelup_vpc_private_subnet-2.id
    route_table_id = aws_route_table.private_route.id
  
}

provider "aws" {
  region = var.AWS_REGION
}

output "myvpc_id" {
  value = aws_vpc.levelup-vpc.id
}

output "public_subnet-1_id" {
    value = aws_subnet.levelup_vpc_public_subnet-1.id
 
}

output "public_subnet-2_id" {
    value = aws_subnet.levelup_vpc_public_subnet-2.id
  
}

output "private_subnet-1_id" {
    value = aws_subnet.levelup_vpc_private_subnet-1.id

}

output "private_subnet-2_id" {
    value = aws_subnet.levelup_vpc_private_subnet-2.id
  
}

