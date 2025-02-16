
resource "aws_vpc" "vpcs" {
  count      = length(var.vpcs)
  cidr_block = var.vpcs[count.index].cidr_block

  tags = {
    Name = var.vpcs[count.index].name
  }
}
