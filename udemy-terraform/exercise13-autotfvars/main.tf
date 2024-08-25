resource "random_id" "bucket_suffix" {
  byte_length = 7
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-autotfvars-${random_id.bucket_suffix.decimal}"
  tags = merge(local.tags, { 
  SupportBy = "Nasim"
 })
}
