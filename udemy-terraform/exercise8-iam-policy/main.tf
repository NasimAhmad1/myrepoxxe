data "aws_iam_policy_document" "static_website" {
    statement {
        sid = "s3publicaccess"
      principals {
        type = "*"
        identifiers = [ "*" ]
      }
      actions = [ "s3:GetObject" ]
      resources = [ "arn:aws:s3:::*/*" ]
    }
  
}

output "polic-output" {
    value = data.aws_iam_policy_document.static_website.json
  
}