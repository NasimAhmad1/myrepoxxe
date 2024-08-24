data "aws_caller_identity" "caller" {}

data "aws_region" "aws-region" {}

output "caller-identity" {
    value = data.aws_caller_identity.caller
  
}

output "region" {
  value = data.aws_region.aws-region.name
}