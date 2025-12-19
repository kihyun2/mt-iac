resource "aws_vpc" "mt-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mt-vpc"
  }
}