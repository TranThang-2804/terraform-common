resource "aws_eks_node_group" "this" {
  count = var.az_count

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.prefix_name}-node-group-${count.index + 1}"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = ["${var.subnet_ids[count.index]}"]
  capacity_type   = var.capacity_type
  instance_types  = var.instance_types

  scaling_config {
    desired_size = ceil(lookup(var.scaling_config, "desired_size", 1) / var.az_count)
    max_size     = ceil(lookup(var.scaling_config, "max_size", 2) / var.az_count)
    min_size     = ceil(lookup(var.scaling_config, "min_size", 1) / var.az_count)
  }

  update_config {
    max_unavailable = try(var.max_unavailable, 1)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]

  lifecycle {
    # ignore_changes = [scaling_config[0].desired_size]
  }

  tags = var.tags
}
