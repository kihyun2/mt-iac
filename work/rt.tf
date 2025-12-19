##############################
# Public Route Table
##############################
resource "aws_route_table" "mt-route-table" {
  vpc_id = aws_vpc.mt-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mt-igw.id
  }

  tags = {
    Name = "mt-route-table"
  }
}

##############################
# Route Table Association (A)
##############################
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.mt-public-subnet-2a.id
  route_table_id = aws_route_table.mt-route-table.id
}