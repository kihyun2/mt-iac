# ##############################
# # Spring Security Group
# ##############################
# resource "aws_security_group" "spring_sg" {
#   name   = "spring-sg"
#   vpc_id = aws_vpc.mt-vpc.id

#   # SSH 접근 허용 (관리용)
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Spring API 포트 접근 허용 (Frontend EC2)
#   ingress {
#     from_port       = 8080
#     to_port         = 8080
#     protocol        = "tcp"
#     security_groups = [aws_security_group.public-sg.id]
#   }

#   # Outbound Allow All (DB 접근 포함)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

#############################
# DB Security Group
#############################
# resource "aws_security_group" "mt-db_sg" {
#   name   = "mt-db-sg"
#   vpc_id = aws_vpc.mt-vpc.id
#   # SSH
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#    # mysql
#    ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     security_groups = [aws_security_group.public-sg.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "mt_db_sg_id" {
#   value = aws_security_group.mt-db_sg.id
# }


# EKS bastion Security Group
resource "aws_security_group" "eks-bastion_sg" {
  name        = "eks-bastion-sg"
  description = "SSH access for EKS bastion"
  vpc_id      = aws_vpc.mt-vpc.id

  ingress {
  description = "SSH from my PC"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}