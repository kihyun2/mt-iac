resource "aws_eks_access_entry" "cluster_admin" {
  cluster_name  = data.aws_eks_cluster.mt_eks.name
  principal_arn = data.aws_iam_role.cluster_admin.arn
}

resource "aws_eks_access_policy_association" "cluster_admin_admin" {
  cluster_name  = data.aws_eks_cluster.mt_eks.name
  principal_arn = data.aws_iam_role.cluster_admin.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
