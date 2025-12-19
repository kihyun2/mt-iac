
# IAM Role (EKS 운영용)
# 1-1. IAM Role
resource "aws_iam_role" "eks_bastion_role" {
  name = "eks-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# 1-2. IAM Policy (EKS 운영 최소 권한)
# resource "aws_iam_policy" "eks_bastion_policy" {
#   name = "eks-bastion-policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "eks:DescribeCluster",
#           "eks:ListClusters",
#           "eks:DescribeNodegroup",
#           "eks:ListNodegroups",
#           "eks:AccessKubernetesApi"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# 1-3. 정책 연결
resource "aws_iam_role_policy_attachment" "eks_policy_attach" {
  role       = aws_iam_role.eks_bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# instance profile
resource "aws_iam_instance_profile" "eks_bastion_profile" {
  name = "yejin-eks-bastion-profile"
  role = aws_iam_role.eks_bastion_role.name

}