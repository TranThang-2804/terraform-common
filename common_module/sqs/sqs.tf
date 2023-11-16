resource "aws_sqs_queue" "this" {
  name                      = "${local.prefix_name}-sqs"
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = var.tags
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "${local.prefix_name}-deadletter-sqs"

  tags = var.tags
}