# Public Route Tables
resource "aws_route_table" "public_rt" {
  for_each = aws_vpc.vpcs  # ✅ Correctly iterate over VPCs

  vpc_id = each.value.id  # ✅ Correct way to reference a map

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igws[each.key].id  
  }

  tags = {
    Name = "${each.key}-PublicRouteTable"
  }
}


# Private Route Tables
resource "aws_route_table" "private_rt" {
  for_each = aws_vpc.vpcs

  vpc_id = each.value.id  
  tags = {
    Name = "${each.key}-PrivateRouteTable"
  }
}

