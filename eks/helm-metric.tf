resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"

  values = [
    file("${path.module}/values/metrics-server.yaml")
  ]
    depends_on = [
    aws_eks_cluster.mt_eks,
    aws_eks_node_group.mt_nodegroup,
    kubernetes_service_account.alb,
    aws_iam_role.alb_controller,
    kubernetes_config_map.aws_auth
  ]
}

