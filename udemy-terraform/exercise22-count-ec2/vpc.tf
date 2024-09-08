locals {
  project = "count-project"
}


resource "aws_vpc" "project-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
      project = local.project
      Name = local.project
    }
  
}

resource "aws_subnet" "subnet1" {
    count = var.subnet-count
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    project = local.project
    name = "${local.project}-${count.index}"
  }
}


