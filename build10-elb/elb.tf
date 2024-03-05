#AWSn ELB Configuration

resource "aws_elb" "launch-elb" {
    name = "launch-elb"
    subnets = [ aws_subnet.public_subnet-1, aws_subnet.public_subnet-2 ]
    security_groups = [ aws_security_group.allow-elb ]

    listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = 80

    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "HTTP:80/"
      interval = 30
      
    }

    cross_zone_load_balancing = true
    connection_draining = true
    connection_draining_timeout = 400
    
    tags = {
        Name = launch-elb
    }
 
}