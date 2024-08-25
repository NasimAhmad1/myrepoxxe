data "aws_ami" "ubuntu" {
    owners = [ "099720109477" ]
    most_recent = true

    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*" ]

    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]

    }
  
}

resource "aws_instance" "ubuntu-instance" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ubuntu.id
    root_block_device {
      volume_size = "20"
      volume_type = "gp3"
      delete_on_termination = true
    }
  
}