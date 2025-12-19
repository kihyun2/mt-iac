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

data "aws_iam_role" "node_role" {
  name = data.terraform_remote_state.base.outputs.node_role_name
}

data "aws_iam_role" "cluster_admin" {
  name = data.terraform_remote_state.base.outputs.cluster_admin_role_name
}
