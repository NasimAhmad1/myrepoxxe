variable "AWS_ACCESS_KEY" {
  default = ""
}

variable "AWS_SECRET_KEY" {}
  
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
  default = "us-east-1"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ssh_key.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "ssh_key"
}