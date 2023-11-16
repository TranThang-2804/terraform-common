resource "aws_ecr_repository" "this" {
  name                 = "${local.prefix_name}-ecr"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = var.tags
}