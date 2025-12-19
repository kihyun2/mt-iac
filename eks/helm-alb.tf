resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  values = [
    file("${path.module}/values/alb-controller.yaml")
  ]

  depends_on = [
    aws_eks_cluster.mt_eks,
    aws_eks_node_group.mt_nodegroup,
    kubernetes_service_account.alb,
    aws_iam_role.alb_controller,
    kubernetes_config_map.aws_auth
  ]
}
