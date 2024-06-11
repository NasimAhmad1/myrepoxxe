variable "AWS_ACCESS_KEY" {
  default = ""
}

variable "AWS_SECRET_KEY" {}

variable "AMI" {
  default = "ami-0059b7cd9f67d8050"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = ssh_key.pub
  
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "ssh_key"
}