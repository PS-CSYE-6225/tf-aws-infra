
/*resource "aws_vpc" "vpcs" {
  count      = length(var.vpcs)
  cidr_block = var.vpcs[count.index].cidr_block

  tags = {
    Name = var.vpcs[count.index].name
  }
}*/

# Fetch all available availability zones in the selected region
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  count      = var.vpc_count
  cidr_block = count.index == 0 ? var.vpc_cidr : var.second_vpc_cidr

  tags = {
    Name = "${var.network_name}-VPC-${count.index + 1}"
  }
}
