data "aws_ami" "ubunut-image" {
  most_recent = true
  owners = [ "099720109477" ]
  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}

resource "aws_instance" "custom-instance" {
  instance_type = var.ec2_instance_type
  ami = data.aws_ami.ubunut-image.id
  

  root_block_device {
    delete_on_termination = true
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  
}