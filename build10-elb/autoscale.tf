#Auto Scaling Launch Configuration
resource "aws_launch_configuration" "launch-1" {
  name_prefix = "launch-1"
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh_key.key_name
  security_groups = [ aws_security_group.allow_ssh.id ]
  user_data = "#!/bin/bash\nyum update\nyum install -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
   
   lifecycle {
     create_before_destroy = true
   }
}


resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#AutoScaling Group

resource "aws_autoscaling_group" "auto-scaling-group" {
  name = "auto-scaling-group"
  min_size = 1
  max_size = 2
  launch_configuration = aws_launch_configuration.launch-1.name
  vpc_zone_identifier = [aws_subnet.public_subnet-1.id, aws_subnet.public_subnet-2.id]
  health_check_grace_period = 200
  health_check_type = "ELB"
  load_balancers = [aws_elb.launch-elb.name]
  force_delete = "true"
  
  tag {
    key = "Name"
    value = "launch-1"
    propagate_at_launch = "true"
  }
}

output "ELB" {
    value = "aws_elb.launch-elb.dns_name"
  }
