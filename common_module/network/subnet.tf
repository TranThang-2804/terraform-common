resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidr_blocks

  availability_zone = element(tolist(var.availability_zones), index(tolist(var.private_subnet_cidr_blocks), each.key) % length(tolist(var.availability_zones)))
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value

  tags = var.tags
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidr_blocks

  availability_zone = element(tolist(var.availability_zones), index(tolist(var.public_subnet_cidr_blocks), each.key) % length(tolist(var.availability_zones)))
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value

  tags = var.tags
}