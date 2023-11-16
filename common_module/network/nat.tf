resource "aws_eip" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc = true

  tags = var.tags

  depends_on = [
    aws_internet_gateway.this,
    aws_subnet.public
  ]
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = var.tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [
    aws_internet_gateway.this,
    aws_eip.this
  ]
}