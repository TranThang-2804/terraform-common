output "function_url" {
  value       = var.enable_url ? aws_lambda_function_url.function_url[0].function_url : null
  description = "URL for lambda function"
}
