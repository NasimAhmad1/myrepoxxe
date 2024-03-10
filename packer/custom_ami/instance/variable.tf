variable "AMIS" {
  type = map
  default = {
        ap-southeast-2 = "ami-023eb5c021738c6d0"
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
    default = "/home/linuxtechiee/.ssh/id_rsa.pub"

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
