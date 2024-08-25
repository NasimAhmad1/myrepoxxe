resource "random_id" "s3-prefix" {
    byte_length = 6
}

resource "aws_s3_bucket" "terraform-tfvars" {
    bucket = "terraform-tfvars-${random_id.s3-prefix.hex}"
}

output "bucketname" {
  value = aws_s3_bucket.terraform-tfvars.bucket
}

data "aws_region" "region" {}

output "region" {
  value = data.aws_region.region.name
}