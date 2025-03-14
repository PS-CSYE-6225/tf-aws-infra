resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-private-subnet-group"
  description = "RDS subnet group for private subnets"

  # Reference the private subnets from your subnet.tf file
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "rds-private-subnet-group"
  }
}