# resource "aws_instance" "mt-db-ec2-01" {
#   ami = "ami-0aff21c8d49b7132b"
#   instance_type = "t3.medium"
#   key_name = "kosta-edu"
#   associate_public_ip_address = false # private
#   subnet_id = aws_subnet.mt-private-subnet-2c.id
#   vpc_security_group_ids = [aws_security_group.mt-db_sg.id]
#   root_block_device {
#     volume_size = "30"
#     volume_type = "gp3"
#     tags = {
#       Name = "mt-db-ec2-01-root"
#     }
#   }
#   tags = {
#       Name = "mt-db-ec2-01"
#   }
# }

# data "terraform_remote_state" "state" {
#   backend = "local"
#   config = {
#     path = "../state/terraform.tfstate"
#   }
# }

# # EBS attach
# resource "aws_volume_attachment" "db_attach" {
#   device_name  = "/dev/sdf"
#   volume_id    = data.terraform_remote_state.state.outputs.db_volume_id
#   instance_id  = aws_instance.mt-db-ec2-01.id
#   force_detach = true
# }

# # bastion 용 public EC2 (localtest 용)
# resource "aws_instance" "mt-bastion-ec2-01" {
#   ami = "ami-0b818a04bc9c2133c"
#   instance_type = "t3.micro"
#   key_name = "kosta-edu"
#   associate_public_ip_address = true # public
#   subnet_id = aws_subnet.mt-public-subnet-2a.id
#   vpc_security_group_ids = [aws_security_group.public-sg.id]
#   root_block_device {
#     volume_size = "8"
#     volume_type = "gp3"
#     tags = {
#       Name = "mt-bastion-ec2-01"
#     }
#   }
#   tags = {
#       Name = "mt-bastion-ec2-01"
#   }
# }

