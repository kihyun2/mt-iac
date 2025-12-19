resource "aws_ebs_volume" "mt_db_volume" {
  availability_zone = "ap-northeast-2c"
  size              = 30
  type              = "gp3"
  tags = {
    Name = "mt-db-ec2-01-ebs"
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

output "db_volume_id" {
  value = aws_ebs_volume.mt_db_volume.id
}
