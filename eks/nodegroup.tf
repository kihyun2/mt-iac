resource "aws_iam_role_policy_attachment" "node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  role       = data.aws_iam_role.node_role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "mt_nodegroup" {
  cluster_name    = data.aws_eks_cluster.mt_eks.name
  node_group_name = "mt-nodegroup"
  node_role_arn   = data.aws_iam_role.node_role.arn

  subnet_ids = data.terraform_remote_state.base.outputs.eks_private_subnet_ids

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  instance_types = ["t3.small"]
}
