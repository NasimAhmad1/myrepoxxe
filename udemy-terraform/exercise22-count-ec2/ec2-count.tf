data "aws_ami" "ubunut" {
    most_recent = true
    owners = [ "099720109477" ]
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }

    filter {
      name   = "virtualization-type"
      values = [ "hvm" ]
    }

  
}

resource "aws_instance" "count-instance" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ubunut.id
    count = var.aws_ec2-count

    tags = {
      name = "${local.project}- ${count.index}"
      project = local.project
    }
  
}