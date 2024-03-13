module "levelup-vpc" {
    source = "../module/vpc"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
  
}

module "levelup-rds" {
    source = "../module/rds"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
    vpc_private_subnet-1 = var.vpc_private_subnet1
    vpc_private_subnet-2 = var.vpc_private_subnet2
    vpc_id = var.vpc_id
  
}

resource "aws_security_group" "levelup-sg" {
    name = "levelup-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.SSH_CIDR_WEB_SERVER}"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}

resource "aws_key_pair" "levelup-key" {
    key_name = "id_rsa"
    public_key = file(var.PATH_TO_KEY)
  
}

resource "aws_launch_configuration" "levelup-config" {
    image_id = lookup(var.AMIS, var.AWS_REGION)
    instance_type = var.INSTANCE_TYPE
    user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
    security_groups = [aws_security_group.levelup-sg.id]
    key_name = aws_key_pair.levelup-key.key_name

    root_block_device {
      volume_size = "20"
      volume_type = "gp2"
    }
}

resource "aws_autoscaling_group" "levelup-asg" {
    name = "levelup-asg"
    max_size = 2
    min_size = 1
    health_check_grace_period = 30
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    launch_configuration = aws_launch_configuration.levelup-config.name
    vpc_zone_identifier = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
    target_group_arns = [ aws_lb_target_group.target-group.arn ]
}

resource "aws_alb" "levelup-alb" {
    name = "${var.ENVIRONMENT}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb-security.id ]
    subnets = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
  
}

# Add target Group

resource "aws_lb_target_group" "target-group" {
    name = "target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
  
}

# Adding HTTP listener
resource "aws_lb_listener" "levelup-listener" {
    load_balancer_arn = aws_alb.levelup-alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.target-group.arn
      type = "forward"
    }
  
}

output "load_balancer_output" {
    value = aws_alb.levelup-alb.dns_name
  
}