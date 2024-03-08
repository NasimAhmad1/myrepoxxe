resource "aws_key_pair" "levelup-key" {
  key_name = levelup-key
  public_key = file(var.path_public_key)
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = var.VPC-ID
  name = "allow-ssh-${var.ENVIRONMENT}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    name = "allow-ssh"
    ENvironment = var.ENVIRONMENT
  }
}


# Create Instance

resource "aws_instance" "my-instance" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type = var.INSTANCE_TYPE
    subnet_id = element(var.PUBLIC_SUBNETS)
    availability_zone = "${var.AWS_REGION}a"
    vpc_security_group_ids = ["${aws_security_group.aws_security_group.allow-ssh.id}"]
    key_name = aws_key_pair.levelup-key.key_name
    tags = {
      name = instance-${var.ENVIRONMENT}
      Environment = var.ENVIRONMENT 
    }
}