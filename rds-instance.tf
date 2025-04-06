resource "aws_db_instance" "csye6225_rds_instance" {
  
  allocated_storage      = 20
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  identifier             = var.identifier
  username               = var.db_user
  password               = random_password.db_password.result
  #kms_key_id             = aws_kms_key.rds_key.arn
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name   = aws_db_parameter_group.csye6225_db_parameter_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = false
  storage_encrypted      = true

  tags = {
    Name        = "csye6225"
    Environment = "Development"
  }


}