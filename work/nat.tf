# Elastic IP for NAT Gateway
resource "aws_eip" "mt-nat-eip" {
  domain = "vpc"

  tags = {
    Name = "mt-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "mt-nat" {
  allocation_id = aws_eip.mt-nat-eip.id
  subnet_id     = aws_subnet.mt-public-subnet-2a.id

  tags = {
    Name = "mt-nat-gateway"
  }

  depends_on = [aws_internet_gateway.mt-igw]
}

# Private Route Table + 연결
##############################
# Private Route Table
##############################

resource "aws_route_table" "mt-private-rt" {
  vpc_id = aws_vpc.mt-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mt-nat.id
  }

  tags = {
    Name = "mt-private-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "private_assoc_2a" {
  subnet_id      = aws_subnet.mt-private-subnet-2a.id
  route_table_id = aws_route_table.mt-private-rt.id
}

resource "aws_route_table_association" "private_assoc_2c" {
  subnet_id      = aws_subnet.mt-private-subnet-2c.id
  route_table_id = aws_route_table.mt-private-rt.id
}
