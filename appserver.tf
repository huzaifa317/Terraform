resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("/home/codespace/.ssh/my_key.pub")
}
resource "aws_instance" "app-server1" {
   ami = "ami-0a0e5d9c7acc336f1"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.private_subnet1.id
   vpc_security_group_ids = [ aws_security_group.main_sg.id ]
   key_name = aws_key_pair.my_key.key_name
   launch_template {
      id      = aws_launch_template.appserver1.id
      version = "$Latest"
   }
   tags = {
     Name = "app-server1"
   }
  
}
resource "aws_instance" "app-server2" {
  ami = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [ aws_security_group.main_sg.id ]
  key_name = aws_key_pair.my_key.key_name
  launch_template {
    id      = aws_launch_template.appserver1.id
    version = "$Latest"
  }
   
  tags = {
    Name = "app-server2"
}
}


