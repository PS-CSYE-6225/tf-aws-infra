# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_launch_template" {
  depends_on = [
    aws_security_group.application_sec_group
  ]
  name          = "csye6225_launch_template"
  image_id      = var.custom_ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }
  user_data = base64encode(<<-EOF
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
sudo chmod 644 $ENV_FILE

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
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.application_sec_group.id]
  }

  # Block device mapping with KMS encryption
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 25
      volume_type = "gp2"
      encrypted   = true
    }
  }
}

