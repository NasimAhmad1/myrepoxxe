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

resource "random_id" "bucket-prefix" {
  byte_length = 4
}

resource "aws_instance" "custom-instance" {
  instance_type = var.ec2_instance_type
  ami = data.aws_ami.ubuntu.id

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2-volume.volume_size
    volume_type = var.ec2-volume.volume_type
  }

  tags = merge(local.common_tag, var.additional_tag )
}

resource "aws_s3_bucket" "output-bucket" {
  bucket = "terraform-bucket-${random_id.bucket-prefix.dec}"
  tags = merge(local.common_tag, var.additional_tag)
}

output "s3-bucket" {
  value = aws_s3_bucket.output-bucket.bucket
  description = "Bucket Created By Terraform"
}


 