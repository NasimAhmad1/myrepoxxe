variable "LEVELUP_VPC_CIDR_BLOCK" {
    type = string
    default = "10.0.0.0/16"
}

variable "ENVIRONMENT" {
  type = string
  default = "Development"
}

variable "LVELUPVPC_PUBLIC_SUBNET-1_CIDR_BLOCK" {
    type = string
    default = "10.0.1.0/24"
  
}

variable "LVELUPVPC_PUBLIC_SUBNET-2_CIDR_BLOCK" {
    type = string
    default = "10.0.2.0/24"
  
}
variable "LVELUPVPC_PRIVATE_SUBNET-1_CIDR_BLOCK" {
    type = string
    default = "10.0.3.0/24"
  
}

variable "LVELUPVPC_PRIVATE_SUBNET-2_CIDR_BLOCK" {
  type = string
  default = "10.0.4.0/24"
}

variable "AWS_REGION" {
    type        = string
    default     = "us-east-2"
}