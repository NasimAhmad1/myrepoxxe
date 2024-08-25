data "aws_ami" "ubuntu" {
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
  ami = data.aws_ami.ubuntu.id

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2-volume-describe.size
    volume_type = var.ec2-volume-describe.type
  }
  tags = merge(var.additional_tag, {
    ManagedBy = "Terraform"
  })
}