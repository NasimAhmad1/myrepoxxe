variable "AMIS" {
  type = map 
  default = {
        us-east-1 = "ami-0440d3b780d96b29d"
        us-east-2 = "ami-068e036cab82122e7"
        us-west-1 = "ami-0454207e5367abf01"
        us-west-2 = "ami-0688ba7eeeeefe3cd"
  }
} 

variable "AWS_REGION" {
  type = string
  default = ""
}

variable "path_public_key" {
    default = "levelup.pub"

}

variable "VPC-ID" {
  type = string
  default = ""
}

variable "ENVIRONMENT" {
  type = string
  default = ""
}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}