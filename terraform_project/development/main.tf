module "dev-vpc" {
    source = "../modules/vpc"
    ENVIRONMENT = var.Env
    AWS_REGION = var.AWS_REGION
  
}

module "dev-instance"{
    source = "../modules/instance"
    ENVIRONMENT = var.Env
    AWS_REGION = var.AWS_REGION
    VPC-ID = module.dev-vpc.myvpc_id
    PUBLIC_SUBNETS = module.dev-vpc.public_subnets

    }
    
    
    provider "aws" {
        region = var.AWS_REGION
      
    }
