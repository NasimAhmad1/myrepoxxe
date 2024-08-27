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

variable "number_list" {
    type = list(number)
    default = [ 1, 3, 5, 6, 8, 10 ]
}

variable "objet_list" {
    type = list(object({
      firstname = string
      lastname = string
    }))
    default = [ {
      firstname = "Nasim"
      lastname = "Ahmad"
    } ]
}

variable "list_map" {
  type = map(number)
  default = {
    "Suraj" = 2
    "Sabbir" = 4
  }
}

variable "users" {
type = list(object({
  username = string
  roles = string
}))
}

variable "user_to_output" {
  type = string
}

