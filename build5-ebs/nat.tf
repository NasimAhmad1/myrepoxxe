#create EIP
resource "aws_eip" "custom_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "custom_nat_gw" {
  allocation_id = aws_eip.custom_eip.allocation_id
  subnet_id = aws_subnet.public_subnet-1
  depends_on = [ aws_internet_gateway.custome-gw ]
}

#Create Private route Table

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.myvpc1
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_nat_gw.id
  }
 tags = {
   Name = private_route
 }
   
}

# Associate route with private Subnet

resource "aws_route_table_association" "private_1a" {
  subnet_id = aws_subnet.private_subnet-1
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id = aws_subnet.private_subnet-2
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_1c" {
    subnet_id = aws_subnet.private_subnet-3
    route_table_id = aws_route_table.private_route
}

