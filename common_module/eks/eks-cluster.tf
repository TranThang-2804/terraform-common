resource "aws_eks_cluster" "this" {
  name     = "${local.prefix_name}-eks-cluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  enabled_cluster_log_types = try(var.enabled_cluster_log_types, ["api", "audit"])

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.this
  ]

  tags = var.tags
}

resource "aws_eks_addon" "addon" {
  for_each = toset(var.addons)

  cluster_name = aws_eks_cluster.this.name
  addon_name   = each.value
}