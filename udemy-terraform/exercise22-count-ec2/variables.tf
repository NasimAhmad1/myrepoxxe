variable "aws_region" {
  type = string
  default = "us-west-1"
} 

variable "AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  default = ""
}

variable "subnet-count" {
  type = number
  default = 2
}

variable "aws_ec2-count" {
  type = number
  default = 1
}
