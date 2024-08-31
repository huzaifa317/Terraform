resource "aws_internet_gateway" "main_vpc-aws_internet_gateway" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      Name ="main_vpc-aws_internet_gateway"
    }
  
}