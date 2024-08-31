resource "aws_launch_template" "appserver1" {
  name = "instance-launch"
  image_id = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.micro" 
}

resource "aws_autoscaling_group" "example" {
  name                = "example-asg"
  launch_template {
    id      = aws_launch_template.appserver1.id
    version = "$Latest"
  }
  min_size             = 1
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.private_subnet1.id,aws_subnet.private_subnet2.id]
}

# Create a scaling policy
resource "aws_autoscaling_policy" "example" {
  name                   = "example-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}