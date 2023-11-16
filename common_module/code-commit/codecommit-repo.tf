
resource "aws_codecommit_repository" "main" {
  repository_name = var.repository_name
  description     = var.description
}