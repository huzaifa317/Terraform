resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "Public-route_tabel-1"
  }

}
resource "aws_route_table" "main2" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "Public-route_tabel-2"
  }

}
resource "aws_route_table" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "Private_subnets_route_tabel_1"
  }
  
}
resource "aws_route_table" "private_subnet2" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    "Name" = "Private_subnets_route_tabel_2"
  }
  
}
resource "aws_route" "main" {
  route_table_id = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_vpc-aws_internet_gateway.id
  
}
resource "aws_route" "main2" {
  route_table_id = aws_route_table.main2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_vpc-aws_internet_gateway.id
  
}

resource "aws_route" "Private_route1" {
  route_table_id = aws_route_table.private_subnet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway1.id
  
}


resource "aws_route" "Private_route2" {
  route_table_id = aws_route_table.private_subnet2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway_2.id
  
}


resource "aws_route_table_association" "public_subnet1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.main.id
}


resource "aws_route_table_association" "public_subnet2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.main2.id
  
}
resource "aws_route_table_association" "private_subnet1" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_subnet.id
  
}

resource "aws_route_table_association" "private_subnet2" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_subnet2.id
  
}

