# Public Route Tables
resource "aws_route_table" "public_rt" {
  count  = length(var.vpcs)
  vpc_id = aws_vpc.vpcs[count.index].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igws[count.index].id
  }

  tags = {
    Name = "PublicRouteTable-${count.index + 1}"
  }
}

# Private Route Tables
resource "aws_route_table" "private_rt" {
  count  = length(var.vpcs)
  vpc_id = aws_vpc.vpcs[count.index].id

  tags = {
    Name = "PrivateRouteTable-${count.index + 1}"
  }
}
