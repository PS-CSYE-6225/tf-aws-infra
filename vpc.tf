
/*resource "aws_vpc" "vpcs" {
  count      = length(var.vpcs)
  cidr_block = var.vpcs[count.index].cidr_block

  tags = {
    Name = var.vpcs[count.index].name
  }
}*/

# Fetch all available availability zones in the selected region
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpcs" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc }

  cidr_block = each.value.cidr_block

  tags = {
    Name = each.key
  }
}

