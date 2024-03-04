resource "aws_key_pair" "ssh_key" {
    key_name = "ssh_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "myinstance" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh_key.key_name
  iam_instance_profile = aws_iam_instance_profile.s3-levelupbucket-role-instanceprofile.name

  tags = {
    Name = "myinstance"
  }
}


output "public_ip" {
  value = aws_instance.myinstance.public_ip
}