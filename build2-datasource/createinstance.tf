data "aws_availability_zones" "useastaz" {}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners = [ "099720109477" ]
  filter {
     name = "name"
     values = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.0.04-amd64-server-*"
  }

  filter {
    name = "name"
    values = ["hvm"]
  }
}

resource "aws_instance" "myfirstinstance" {
  ami = "aws_ami.latest-ubuntu.id"
  instance_type = "t2.micro"
  availability_zone = "aws_availability_zones.useastaz.name[0]"  

  tags = {
    Name = "custom_instance"
  }
 
}