##############################
# Private Subnets (EKS Nodes)
##############################

resource "aws_subnet" "mt-private-subnet-2a" {
  vpc_id            = aws_vpc.mt-vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name                     = "mt-private-subnet-2a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/mt-eks"    = "shared"
  }
}

resource "aws_subnet" "mt-private-subnet-2c" {
  vpc_id            = aws_vpc.mt-vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name                     = "mt-private-subnet-2c"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/mt-eks"    = "shared"
  }
}
