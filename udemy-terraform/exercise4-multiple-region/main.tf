resource "random_id" "bucket_suffix" {
    byte_length = 6
}

resource "aws_s3_bucket"  "project-bucket" {
    bucket = "project-bucket-${random_id.bucket_suffix.dec}"
    tags = {
      Name = Project-bucket
      MaintainedBy = Terraform
    }
}

resource "aws_s3_bucket" "project1-bukcet" {
    bucket = "project1-bucket-${random_id.bucket_suffix.hex}"
    provider = aws.us-west
    tags = {
      Name = Project-bucket
      MaintainedBy = Terraform
    }
  
}