data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../work/terraform.tfstate"
  }
}
data "aws_eks_cluster_auth" "mt_eks" {
  name = data.terraform_remote_state.base.outputs.aws_eks_cluster
}

data "aws_eks_cluster" "mt_eks" {
  name = data.terraform_remote_state.base.outputs.aws_eks_cluster
}

data "tls_certificate" "oidc" {
  url = data.aws_eks_cluster.mt_eks.identity[0].oidc[0].issuer
}