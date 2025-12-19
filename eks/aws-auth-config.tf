# # -----------------------------
# # aws-auth ConfigMap
# # -----------------------------
# resource "kubernetes_config_map" "aws_auth" {
#     provider = kubernetes
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = <<YAML
# # EKS Node Group Role
# - rolearn: data.terraform_remote_state.base.outputs.node_role_arn
#   username: system:node:{{EC2PrivateDNSName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:node-proxier
# YAML
#   }
# }
