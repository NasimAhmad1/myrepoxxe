data "aws_ami"  "ubuntu-image" {
    owners = ["099720109477"]
    most_recent = true

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
  
}
output "image_id" {
    value = data.aws_ami.ubuntu-image.id
  
}

resource "aws_instance" "project-instance" {
    ami = data.aws_ami.ubuntu-image.id
    instance_type = "t2.micro"

    root_block_device {
      delete_on_termination = true
      volume_size = "20"
      volume_type = "gp3"

    }
}