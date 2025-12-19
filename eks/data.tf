data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../work/terraform.tfstate"
  }
}
data "aws_eks_cluster_auth" "mt_eks" {
  name = aws_eks_cluster.mt_eks.name
  depends_on = [ aws_eks_cluster.mt_eks ]
}

data "aws_eks_cluster" "mt_eks" {
  name = aws_eks_cluster.mt_eks.name
  depends_on = [ aws_eks_cluster.mt_eks ]
}

data "tls_certificate" "oidc" {
  url = data.aws_eks_cluster.mt_eks.identity[0].oidc[0].issuer
  depends_on = [ data.aws_eks_cluster.mt_eks ]
}