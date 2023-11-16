output "ssh_url" {
  value = aws_codecommit_repository.main.clone_url_ssh
}

output "http_url" {
  value = aws_codecommit_repository.main.clone_url_http
}