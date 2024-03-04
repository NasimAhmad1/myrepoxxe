# Create IAM user using TF

resource "aws_iam_user" "adminuser1" {
    name = "adminuser1"  
}

resource "aws_iam_user" "adminuser2" {
    name = "adminuser2"
}

# Create Group 

resource "aws_iam_group" "admin-group" {
    name = "admin-group"
}

# Add user im group

resource "aws_iam_group_membership" "user-group" {
  name = "user-group"
  users = [aws_iam_user.adminuser1.name, aws_iam_user.adminuser2.name  ]
  group = aws_iam_group.admin-group.name
}

resource "aws_iam_policy_attachment" "admin_user_attachemnt" {
  name = "admin_user_attachemn"
  groups = [ aws_iam_group.admin-group.name ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}