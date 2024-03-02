data "aws_availability_zones" "useastaz" {}

data "aws_ip_ranges" "useast12" {
  regions = ["us-east-1","us-east-2"]
  services = ["ec2"]
}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners = ["amazon"]
  filter {
     name = "name"
     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "sg_custom" {
  name = "sg_custom"

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.useast12.cidr_blocks,  0, 50)
  }
  tags = {
    createDate= data.aws_ip_ranges.useast12.create_date
    SyncToken = data.aws_ip_ranges.useast12.sync_token
  }  
}

resource "aws_instance" "myfirstinstance" {
  ami = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.useastaz.names[0]

  provisioner "local-exec" {
   command = "echo ${aws_instance.myfirstinstance.private_ip} >> privateIp.txt"
 }
  tags = {
    Name = "custom_instance"
  }
}
output "public_ip" {
  value = aws_instance.myfirstinstance.public_ip
}