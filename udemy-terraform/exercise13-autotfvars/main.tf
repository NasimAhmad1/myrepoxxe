resource "random_id" "bucket_suffix" {
  byte_length = 7
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-autotfvars-${random_id.bucket_suffix.dec}"
  tags = merge(local.tags, { 
  SupportBy = "Nasim"
 })
}

data "aws_region" "region" {}

output "aws_region" {
  value = data.aws_region.region.name
}

output "s3-bucket" {
  value = aws_s3_bucket.bucket.bucket
}
