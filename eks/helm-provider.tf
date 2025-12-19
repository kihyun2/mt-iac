provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.mt_eks.endpoint
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.mt_eks.certificate_authority[0].data
    )
    token = data.aws_eks_cluster_auth.mt_eks.token
  }

}
