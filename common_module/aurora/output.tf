output "aurora_read_endpoint" {
  value = module.aurora.cluster_reader_endpoint
}

output "aurora_cluster_user_name" {
  value = module.aurora.cluster_master_username
}

output "aurora_cluster_password" {
  value = module.aurora.cluster_master_password
}

output "aurora_cluster_default_endpoint" {
  value = module.aurora.cluster_endpoint
}