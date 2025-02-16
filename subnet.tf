# Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.vpcs) * length(var.vpcs[0].public_subnets)
  vpc_id                  = aws_vpc.vpcs[floor(count.index / length(var.vpcs[0].public_subnets))].id
  cidr_block              = var.vpcs[floor(count.index / length(var.vpcs[0].public_subnets))].public_subnets[count.index % length(var.vpcs[0].public_subnets)]
  availability_zone       = var.vpcs[floor(count.index / length(var.vpcs[0].public_subnets))].availability_zones[count.index % length(var.vpcs[0].availability_zones)]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.vpcs) * length(var.vpcs[0].private_subnets)
  vpc_id            = aws_vpc.vpcs[floor(count.index / length(var.vpcs[0].private_subnets))].id
  cidr_block        = var.vpcs[floor(count.index / length(var.vpcs[0].private_subnets))].private_subnets[count.index % length(var.vpcs[0].private_subnets)]
  availability_zone = var.vpcs[floor(count.index / length(var.vpcs[0].private_subnets))].availability_zones[count.index % length(var.vpcs[0].availability_zones)]

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}
