resource "aws_key_pair" "lookup_key" {
  key_name = "lookup_key"
  public_key = "file(var.public_keys)"
}

resource "aws_instance" "myfirstinstance" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.lookup_key.key_name

  tags = {
    Name = "custom_instance"
  }


  provisioner "file" {
    source = "installngnix.sh"
    destination = "/tmp/installngnix.sh"

  }
  
  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod +x /tmp/installngnix.sh"
        "sudo sed -i -e 's/\r$\\' /tmp/installngnix.sh"
        "sudo /tmp/installngnix.sh"
    ]
    
  }
  connection {
    host = coalesce(self.public_ip,self.private_ip)
    user = var.INSTANCE_USERNAME
    private_key = file(var.private_keys)
  }
}