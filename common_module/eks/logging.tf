resource "aws_cloudwatch_log_group" "this" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${local.prefix_name}/cluster"
  retention_in_days = try(var.eks_log_retention_in_days, 7)

  tags = var.tags
}