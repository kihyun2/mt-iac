resource "aws_iam_role" "node_role" {
  name = "mt-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "mt_nodegroup" {
  cluster_name    = aws_eks_cluster.mt_eks.name
  node_group_name = "mt-nodegroup"
  node_role_arn  = aws_iam_role.node_role.arn
 subnet_ids = [
    aws_subnet.mt-private-subnet-2a.id,
    aws_subnet.mt-private-subnet-2c.id
  ]
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.medium"]
}