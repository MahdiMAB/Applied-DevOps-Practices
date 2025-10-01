resource "aws_ebs_volume" "wordpress_volume" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = "gp2" 
  tags = {
    Name = "wordpress-data-volume"
  }
}
