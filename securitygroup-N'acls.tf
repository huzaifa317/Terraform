resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id

   
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    
  }

  tags = {
    Name = "main-sg"
  }
}
resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main_vpc.id

 ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no = 101
    action = "allow"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_block = "0.0.0.0/0"

  }

  // Allow inbound HTTPS traffic from the internet
  ingress {
    rule_no    = 102
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }

  // Allow outbound traffic to your private subnets
    egress {
    rule_no = 204
    action = "allow"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
  }
  
  }