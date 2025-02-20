resource "aws_internet_gateway" "igws" {
  for_each = aws_vpc.vpcs

  vpc_id = each.value.id
  tags = {
    Name = "${each.key}-InternetGateway"
  }
}
