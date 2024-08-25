variable "AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    default = ""
}

variable "aws_region" {
  type = string
  default = "eu-west-1"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
  validation {
    condition = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only support t2.micro and t3.micro instance type"
  }
  
}

variable "volume_type" {
  type = string
  default = "gp3"
}

variable "volume_size" {
  type = number
  default = 20
}