# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each = { for subnet_data in flatten([
    for vpc in var.vpcs : [
      for idx, subnet in vpc.public_subnets : {
        vpc_name = vpc.name
        cidr     = subnet
        idx      = idx
      }
    ]
  ]) : "${subnet_data.vpc_name}-${subnet_data.idx}" => subnet_data }

  vpc_id                  = aws_vpc.vpcs[each.value.vpc_name].id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available.names[each.value.idx % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name = "${each.value.vpc_name}-PublicSubnet-${each.value.idx + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each = { for subnet_data in flatten([
    for vpc in var.vpcs : [
      for idx, subnet in vpc.private_subnets : {
        vpc_name = vpc.name
        cidr     = subnet
        idx      = idx
      }
    ]
  ]) : "${subnet_data.vpc_name}-${subnet_data.idx}" => subnet_data }

  vpc_id            = aws_vpc.vpcs[each.value.vpc_name].id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[each.value.idx % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "${each.value.vpc_name}-PrivateSubnet-${each.value.idx + 1}"
  }
}
