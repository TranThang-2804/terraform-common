output "private_subnet_ids" {
  value = [for k, v in aws_subnet.private : v.id]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}