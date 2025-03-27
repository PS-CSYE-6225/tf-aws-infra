resource "aws_instance" "web_app_instance" {
  ami                    = var.custom_ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.application_sec_group.id]

  # Root Volume (EBS)
  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  depends_on = [aws_db_instance.csye6225_rds_instance]

  user_data = <<-EOF
#!/bin/bash
set -e  # Stop script execution on error

# Wait to ensure EC2 instance has fully started
sleep 30

# Define environment file path
ENV_FILE="/opt/webapp/.env"

# Ensure the directory exists
sudo mkdir -p /opt/webapp

# Remove existing .env file (if any) and create a new one
sudo rm -f $ENV_FILE
sudo touch $ENV_FILE
sudo chmod 666 $ENV_FILE

# Write environment variables
echo "DB_NAME=${var.db_name}" | sudo tee -a $ENV_FILE
echo "DB_HOST=$(echo ${aws_db_instance.csye6225_rds_instance.address} | cut -d':' -f1)" | sudo tee -a $ENV_FILE
echo "DB_PASSWORD=${var.db_password}" | sudo tee -a $ENV_FILE
echo "DB_USER=${var.db_user}" | sudo tee -a $ENV_FILE
echo "DB_PORT=${var.db_port}" | sudo tee -a $ENV_FILE
echo "S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.id}" | sudo tee -a $ENV_FILE
echo "AWS_REGION=${var.aws_region}" | sudo tee -a $ENV_FILE
sudo systemctl restart csye6225-aws.service
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
sudo npm install -g statsd-cloudwatch-backend
statsd /opt/webapp/statsd_config.js

EOF


  disable_api_termination = false

  tags = {
    Name = "web-app-instance"
  }
}
