output "instance_id" {
  value = aws_instance.web_server.id
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}

output "availability_zone" {
  value = aws_instance.web_server.availability_zone
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}