# eks 전용 리소스

resource "aws_iam_role" "eks_cluster_role" {
  name = "mt-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "mt_eks" {
  name     = "mt-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.terraform_remote_state.base.outputs.eks_private_subnet_ids

    endpoint_private_access = true #VPC 내부에서도 접근 가능하게 설정 (보통 둘 다 true로 둠)
    endpoint_public_access  = true # 클러스터 API 서버를 퍼블릭에서 접근 가능하게 설정
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}