resource "aws_instance" "project1-ec2" {
    ami = var.AMI 
    vpc_security_group_ids = [ aws_security_group.project1-sg.id ]
    subnet_id = aws_subnet.public_subnet1.id
    key_name = aws_key_pair.project1-key.key_name
    tags = {
      Name = "project1-ec2"
    }
  
}

resource "aws_key_pair" "project1-key" {
    key_name = project1-key
    public_key = file(var.PATH_TO_PUBLIC_KEY)
  
}