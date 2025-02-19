


# Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.vpcs[0].public_subnets)
  vpc_id                  = aws_vpc.vpcs[0].id
  cidr_block              = var.vpcs[0].public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.vpcs[0].private_subnets)
  vpc_id            = aws_vpc.vpcs[0].id
  cidr_block        = var.vpcs[0].private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}
