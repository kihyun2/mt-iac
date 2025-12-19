##############################
# Subnets
##############################
# Public Subnet (Frontend)
# resource "aws_subnet" "cookrep-public-subnet-a" {
#   vpc_id                  = aws_vpc.cookrep-vpc.id
#   cidr_block              = "10.0.3.0/24"
#   availability_zone       = "ap-northeast-2a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "cookrep-public-subnet-a"
#   }
# }



#########################
# 2. 서브넷
#########################
# Public Subnet (Bastion / ArgoCD / Monitoring)
resource "aws_subnet" "mt-public-subnet-2a" {
  vpc_id                  = aws_vpc.mt-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name       = "mt-public-subnet-2a"
    created-by = "terraform"
    service    = "bastion-argocd-monitoring"
    "kubernetes.io/cluster/mt-eks"    = "shared"
  }
}

