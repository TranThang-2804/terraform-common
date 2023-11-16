resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "public_subnet_route_table" {
  for_each = var.public_subnet_cidr_blocks

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [
    aws_subnet.public
  ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = aws_nat_gateway.this

    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = route.value.id
    }
  }

  tags = var.tags
}

resource "aws_route_table_association" "private_subnet_route_table" {
  for_each = var.private_subnet_cidr_blocks

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}
