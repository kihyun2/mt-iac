output "vpc_id" {
  value = aws_vpc.mt-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.mt-public-subnet-2a.id
}

output "eks_node_subnet_ids" {
  value = [
    aws_subnet.mt-public-subnet-2a.id
    # 나중에 private subnet 추가 시 여기에 추가
  ]
}

output "eks_private_subnet_ids" {
  value = [
    aws_subnet.mt-private-subnet-2a.id,
    aws_subnet.mt-private-subnet-2c.id
  ]
}

output "eks_bastion_sg_id" {
  value = aws_security_group.eks-bastion_sg.id
}