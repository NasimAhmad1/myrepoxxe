variable "aws_region" {
  type = string
  default = ""
} 

variable "AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  default = ""
}

variable "ec2_instance_type" {
    type = string
    default = "t2.micro"
    validation {
      condition = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
      error_message = "Only t2 adn t3 micro instance type are supported."
    }
}

variable "additional_tag" {
  type = map(string)
  default = {
    "Env" = "Prod"
  }

}

variable "ec2-volume" {
  type = object({
    volume_size = number
    volume_type = string
  })

  default = {
    volume_size = 20
    volume_type = "gp3"
  }
}
