output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value       = [aws_subnet.pub_subnet_az1.id, aws_subnet.pub_subnet_az2.id]
}

output "public_subnet_az1" {
  value       = aws_subnet.pub_subnet_az1.id
}