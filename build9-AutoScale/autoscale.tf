#Auto Scaling Launch Configuration
resource "aws_launch_configuration" "launch-1" {
  name_prefix = "launch-1"
  image_id = file(var.AMIS, var.AWS_ACCESS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh_key.key_name
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
  vpc_zone_identifier = ["us-east-1a", "us-east-1b"]
  health_check_grace_period = 200
  health_check_type = "EC2"
  force_delete = "true"
  
  tag {
    key = "Name"
    value = launch-1
    propagate_at_launch = "true"
  }

}

#AutoScaling Configuration policy

resource "aws_autoscaling_policy" "cpu-up-policy" {
   name = "cpu-up-policy"
   autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name
   adjustment_type = "ChangeInCapacity"
   scaling_adjustment = "1"
   cooldown = "200"
   policy_type = "SimpleScaling"
}

#Auto Scaling Cloud Watch Monitoring

resource "aws_cloudwatch_metric_alarm" "scale-up" {
 alarm_name =  "scale-up"
 comparison_operator = "GreaterThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name = "CPUUtilization"
 namespace = "AWS/EC2"
 period = "120"
 threshold = "30"
 statistic = "Average" 

 dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.auto-scaling-group.name
 }

 actions_enabled = "true"
 alarm_actions = [aws_autoscaling_policy.cpu-up-policy.arn]
}


#Auto Descaling Policy

resource "aws_autoscaling_policy" "cpu-down-policy" {
   name = "cpu-down-policy"
   autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name
   adjustment_type = "ChangeInCapacity"
   scaling_adjustment = "-1"
   cooldown = "200"
   policy_type = "SimpleScaling"
}

#Descaling CloudWatch Metric Alarm

resource "aws_cloudwatch_metric_alarm" "scale-down" {
 alarm_name =  "scale-down"
 comparison_operator = "LessThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name = "CPUUtilization"
 namespace = "AWS/EC2"
 period = "120"
 threshold = "10"
 statistic = "Average" 

 dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.auto-scaling-group.name
 }

 actions_enabled = "true"
 alarm_actions = [aws_autoscaling_policy.cpu-down-policy.arn]
}