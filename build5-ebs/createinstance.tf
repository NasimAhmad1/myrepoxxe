resource "aws_key_pair" "ssh_key" {
    key_name = "ssh_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "myinstance" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.public_subnet-1.id

  tags = {
    Name = "myinstance"
  }
}

# EBS Resource Creation
resource "aws_ebs_volume" "volume1" {
  type = "gp2"
  size = 50
  availability_zone = "us-east-1a"

  tags = {
    Name = EBS-Volume-1
  }
}

# Attached EBS volume
resource "aws_volume_attachment" "ebs-volume-1" {
  instance_id = aws_instance.myinstance.id
  volume_id = aws_ebs_volume.volume1.id
  device_name =  "/dev/xvdb"
}