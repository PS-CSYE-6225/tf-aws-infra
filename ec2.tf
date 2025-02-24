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

  disable_api_termination = false

  tags = {
    Name = "web-app-instance"
  }
}
