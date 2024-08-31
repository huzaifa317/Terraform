resource "aws_lb" "first_lb" {
  name = "first-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.main_sg.id ]
  subnets = [ aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id ]
  tags = {
    Name = "web"
  }
  
}
resource "aws_lb_target_group" "tg" {
  name = "FirstTg"
  protocol = "HTTP"
  port = 80
  vpc_id = aws_vpc.main_vpc.id
  
  health_check {
    path = "/"
    port = "traffic-port"
  }
  
}
resource "aws_lb_target_group_attachment" "attach1" {
   target_group_arn = aws_lb_target_group.tg.arn
   target_id = aws_instance.app-server1.id
   port = 80
  
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.id
  target_id = aws_instance.app-server2.id
  port = 80
  
}
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.first_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
  
}