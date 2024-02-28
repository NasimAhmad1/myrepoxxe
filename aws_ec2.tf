resource "aws_instance" "webserver" {
  ami = ami-014746511ff655383	
  instance_type = "t2.micro"
}