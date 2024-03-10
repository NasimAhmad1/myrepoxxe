   # Custom VPC using module
  module "levelup-vpc" {
     source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"
     name = "vpc-${var.ENVIRONMENT}"
     cidr = "10.0.0.0/16"
     azs = ["${var.AWS_REGION}a","${var.AWS_REGION}b","${var.AWS_REGION}c"]
     private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
     public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
    enable_nat_gateway = false
    enable_vpn_gateway = false
 
    tags = {
       terraform = "true"
       Environment = "var.ENVIRONMENT"
    }
 
  }
 
  output "myvpc_id" {
     description = "VPC IDs"
     value = module.levelup-vpc.vpc_id
  }
 
  output "private_subnets" {
    value = module.levelup-vpc.private_subnets
  }
 
  output "public_subnets" {
    value = module.levelup-vpc.public_subnets
