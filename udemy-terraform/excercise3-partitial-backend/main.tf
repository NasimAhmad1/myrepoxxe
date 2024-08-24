resource "random_id" "bucket_suffix" {
    byte_length = 6
}

resource "aws_s3_bucket" "project1" {
    bucket = "terraform-bucket-${random_id.bucket_suffix.hex}"
}

output "s3-bucket" {
    value = aws_s3_bucket.project1.bucket
}