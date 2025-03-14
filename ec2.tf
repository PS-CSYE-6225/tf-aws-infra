resource "aws_instance" "web_app_instance" {
  ami                    = var.custom_ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.application_sec_group.id]

  # Root Volume (EBS)
  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  depends_on = [aws_db_instance.csye6225_rds_instance]

  user_data = <<-EOT
 #!/bin/bash
 rm -f /opt/webapp/.env
 touch /opt/webapp/.env
 sudo echo "DATABASE=${var.db_name}" | sudo tee -a /opt/webapp/.env
sudo echo "HOST=${aws_db_instance.csye6225_rds_instance.endpoint}" | sudo tee -a /opt/webapp/.env
sudo echo "PASSWORD=${var.db_password}" | sudo tee -a /opt/webapp/.env
sudo echo "USER=${var.db_user}" | sudo tee -a /opt/webapp/.env
sudo echo "PORT=${var.app_port}" | sudo tee -a /opt/webapp/.env
sudo echo "S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.id}" | sudo tee -a /opt/webapp/.env
sudo echo "AWS_REGION=${var.aws_region}" | sudo tee -a /opt/webapp/.env
sudo systemctl restart csye6225-aws.service


EOT


  disable_api_termination = false

  tags = {
    Name = "web-app-instance"
  }
}
