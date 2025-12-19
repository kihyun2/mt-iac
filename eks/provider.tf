terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
  }
}

############################
# 1️⃣ AWS Provider
############################
provider "aws" {
  region = "ap-northeast-2"
}


############################
# 3️⃣ Kubernetes Provider
############################
provider "kubernetes" {
  host                   = data.aws_eks_cluster.mt_eks.endpoint
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.mt_eks.certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.mt_eks.token
}



############################
# 5️⃣ Kubectl Provider
############################
provider "kubectl" {
  host                   = data.aws_eks_cluster.mt_eks.endpoint
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.mt_eks.certificate_authority[0].data
  )

    token = data.aws_eks_cluster_auth.mt_eks.token

}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.mt_eks.endpoint
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.mt_eks.certificate_authority[0].data
    )
    token = data.aws_eks_cluster_auth.mt_eks.token
  }
}