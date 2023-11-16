data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.zip_file_path
}

resource "aws_lambda_function" "this" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.zip_file_path
  function_name = "${local.prefix_name}-function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime

  tags = var.tags
}

resource "aws_lambda_function_url" "function_url" {
  count              = var.enable_url ? 1 : 0
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}
