# Create Security Group
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.myvpc1
  name = "allow-ssh"
  description = "Allow ssh from instance"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = "0.0.0.0/0"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }

  tags = {
    name = allow_ssh
  }
}