output "primary_db_address" {
  value       = aws_db_instance.wordpress_db_az1.address
}

output "secondary_db_address" {
  value       = aws_db_instance.wordpress_db_az2.address
}
