resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

locals {
  subnet_bits      = 4
  subnet_offset    = 0
}

resource "aws_subnet" "subnets" {
  count             = 3
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, local.subnet_bits, local.subnet_offset + count.index)
}
