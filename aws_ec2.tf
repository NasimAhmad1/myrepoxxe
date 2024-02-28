resource "aws_instance" "webserver" {
  count = 3
  ami = "ami-02ca28e7c7b8f8be1"
  instance_type = "t2.micro"
  tags = {
    Name = "webservers-${count.index}"
  }
}