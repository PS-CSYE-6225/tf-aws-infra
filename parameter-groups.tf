# RDS Parameter Group
resource "aws_db_parameter_group" "csye6225_db_parameter_group" {
  name        = "csye6225-db-parameter-group"
  family      = var.db_family
  description = "Parameter group for the RDS instance"

  parameter {
    name  = "require_secure_transport"
    value = "0"
  }


  tags = {
    Name = "csye6225-db-parameter-group"
  }

}