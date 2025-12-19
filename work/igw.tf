resource "aws_internet_gateway" "mt-igw" {
  vpc_id = aws_vpc.mt-vpc.id

  tags = {
    Name = "mt-igw"
  }
}
