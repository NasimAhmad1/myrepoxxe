data "aws_availability_zones" "useastaz" {}

data "aws_ip_ranges" "useast12" {
  regions = "var.AWS_REGION"
  services = [ "ec2" ]
}

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

resource "aws_security_group" "sg-custom" {
  name = "sg-custom"

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.useast12.cidr_blocks,  0,50)
  }
  tags = {
    createDate= data.aws_ip_ranges.useast12.create_date
    SyncToken = data.aws_ip_ranges.useast12.sync_token
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