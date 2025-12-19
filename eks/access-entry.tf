# Access Entry 리소스 (인증)
resource "aws_eks_access_entry" "bastion" {
  cluster_name  = data.aws_eks_cluster.mt_eks.name
  principal_arn = aws_iam_role.eks_bastion_role.arn
}

# Access Policy 연결 (인가 = RBAC)
resource "aws_eks_access_policy_association" "bastion_admin" {
  cluster_name  = data.aws_eks_cluster.mt_eks.name
  principal_arn = aws_iam_role.eks_bastion_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}