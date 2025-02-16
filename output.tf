output "vpc_ids" {
  description = "List of VPC IDs"
  value       = aws_vpc.vpcs[*].id
}

output "public_subnets" {
  description = "List of Public Subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "List of Private Subnets"
  value       = aws_subnet.private_subnets[*].id
}
