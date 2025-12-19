# EKS Bastion Host
resource "aws_instance" "eks_bastion" {
  ami                         = "ami-0b818a04bc9c2133c"
  instance_type               = "t3.small"
  subnet_id                   = data.terraform_remote_state.base.outputs.public_subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.base.outputs.eks_bastion_sg_id]
  key_name                    = "kosta-edu"
  iam_instance_profile        = aws_iam_instance_profile.eks_bastion_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "eks-bastion-host"
  }
}