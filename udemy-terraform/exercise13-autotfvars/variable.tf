variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  default = ""
}

locals {
  tags = {
    MaintainedBy = "nasim"
  }
}
