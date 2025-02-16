

resource "aws_internet_gateway" "igws" {
  count  = length(var.vpcs)
  vpc_id = aws_vpc.vpcs[count.index].id

  tags = {
    Name = "InternetGateway-${count.index + 1}"
  }
}
