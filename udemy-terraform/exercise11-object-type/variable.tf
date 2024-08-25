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

variable "ec2-volume-describe" {
  type = object({
    size = number
    type = string
  })

  default = {
    size = 20
    type = "gp3"
  }
  
}

variable "additional_tag" {
  type = map(string)
  default = {
    Env = "Prod"
  }
}