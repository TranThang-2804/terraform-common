resource "aws_cloudwatch_event_rule" "console" {
  name        = "${local.prefix_name}-event-rule"
  description = "This is the rule for ${var.module_name}"

  event_pattern = jsonencode({
    detail-type = [
      "AWS Console Sign In via CloudTrail"
    ]
  })

  tags = var.tags
}
