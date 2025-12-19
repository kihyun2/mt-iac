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

output "aws_eks_cluster" {
  value = aws_eks_cluster.mt_eks.name
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
  
}
output "node_role_name" {
  value = aws_iam_role.node_role.name
  
}

output "cluster_admin_role_name" {
  value = aws_iam_role.cluster_admin.name
}
