resource "aws_instance" "webserver" {
  ami = "ami-07e1aeb90edb268a3"
  instance_type = "t2.micro"
}