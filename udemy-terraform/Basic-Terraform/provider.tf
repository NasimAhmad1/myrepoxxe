terraform {
  required_version = "~>1.3"

  backend "s3" {
    bucket = "terraform-project-r1"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "terraform-state-table"
    
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.4"
    }
  }
}
provider "aws" {
  region = "us-east-1"
  access_key = {}
  secret_key = {}
  default_tags  {
    tags = {
      BuildBy = "Terraform"
      MaintainedBy = "Nasim Ahmad"
      project = "Basic terraform"
    }
    
  }
}