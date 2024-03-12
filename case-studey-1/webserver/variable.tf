variable "ENVIRONMENT" {
   type =  string
   default = "Development" 
}

variable "AWS_REGION" {
  type = string
  default = "us-east-2"
}

variable "vpc_private_subnet1" {
    type = string
    default = ""
  
}

variable "vpc_private_subnet2" {
    type = string
    default = ""
}

variable "vpc_id" {
    type = string
    default = ""
  
}

variable "SSH_CIDR_WEB_SERVER" {
    type = string
    default = "0.0.0.0/0"
  
}
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0f40c8f97004632f9"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-02c8896b265d8c480"
        eu-west-1 = "ami-0cdd3aca00188622e"

    }
  
}

variable "INSTANCE_TYPE" {
    type = string
    default = "t2.micro"
}

variable "vpc_public_subnet1" {
  type = string
  default = ""
}

variable "vpc_public_subnet2" {
    type = string
    default = ""
  
}

variable "PATH_TO_KEY" {
    type = string
    default = "/home/linuxtechiee/.ssh/id_rsa.pub"
  
}