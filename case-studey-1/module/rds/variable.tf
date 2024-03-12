variable "ENVIRONMENT" {
  type = string
  default = "Development"
}

variable "AWS_REGION" {
  type = string
  default = "us-east-2"
}

variable "vpc_private_subnet-1" {
  type = string
  default = ""
}

variable "vpc_private_subnet-2" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "RDS_CIDR" {
  type = string
  default = "0.0.0.0/0"
}
variable "LEVELUP_RDS_ALLOCATED_STORAGE" {
  type = string
  default = "20"
}

variable "RDS_ENGINE" {
    type = string
    default = "mysql"
  
}

variable "RDS_ENGINE_VERSION" {
    type = string
    default = "8.0.36"
}

variable "BACKUP" {
  default = "7"
}

variable "PUBLIC" {
  default = "true"
}

variable "USER" {
  type = string
    default = "admin"
  
}

variable "PASSWD" {
  type = string
  default = "test123"
}

variable "DB_INSTANCE_CLASS" {
  type = string
  default = "db.t3.micro"
  
}