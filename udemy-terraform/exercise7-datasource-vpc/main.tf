data "aws_vpc" "prod-vpc" {
    tags = {
      Env = "Prod"
    }
}

output "vpc-id" {
    value = data.aws_vpc.prod-vpc.id
}