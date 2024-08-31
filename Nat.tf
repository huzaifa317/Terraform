
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_eip" "nat_eip2" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "nat1"
  }

  depends_on = [aws_internet_gateway.main_vpc-aws_internet_gateway]
}
resource "aws_nat_gateway" "nat_gateway_2" {
    allocation_id = aws_eip.nat_eip2.id
    subnet_id = aws_subnet.public_subnet2.id
    tags = {
      Name = "nat2"
    }
  depends_on = [ aws_internet_gateway.main_vpc-aws_internet_gateway ]
}