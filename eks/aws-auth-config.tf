# -----------------------------
# aws-auth ConfigMap
# -----------------------------
resource "kubernetes_config_map" "aws_auth" {
    provider = kubernetes
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
# EKS Node Group Role
- rolearn: ${aws_iam_role.node_role.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
    - system:node-proxier
YAML
  }

  depends_on = [
    aws_eks_cluster.mt_eks,
    aws_eks_node_group.mt_nodegroup
  ]
}
