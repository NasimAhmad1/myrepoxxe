resource "aws_key_pair" "ssh_key" {
    key_name = "ssh_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "myinstance" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.public_subnet-1.id

  tags = {
    Name = "myinstance"
  }
}


output "public_ip" {
  value = aws_instance.myinstance.public_ip
}