# ##########################
# # TAGGING MODULE
# ##########################

# module "tagging" {
#   source = "./common_module/tagging"

#   environment    = local.global_tags.environment
#   provisioned_by = local.global_tags.provisioned_by
#   project        = local.global_tags.project
#   owner          = local.global_tags.owner
#   name           = local.global_tags.name
# }

##########################
# S3 MODULE
##########################

module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.1"

  for_each = local.buckets

  bucket = can(each.value.bucket_prefix) ? null : each.key

  acceleration_status = try(each.value.acceleration_status, null)
  bucket_prefix       = try(each.value.bucket_prefix, null)
  policy              = try(null)

  # Optional Inputs
  access_log_delivery_policy_source_accounts = try(each.value.access_log_delivery_policy_source_accounts, [])
  access_log_delivery_policy_source_buckets  = try(each.value.access_log_delivery_policy_source_buckets, [])
  acl                                        = try(each.value.acl, null)
  analytics_configuration                    = try(each.value.acl, {})
  analytics_self_source_destination          = try(each.value.analytics_self_source_destination, false)
  analytics_source_account_id                = try(each.value.analytics_source_account_id, false)
  attach_deny_insecure_transport_policy      = try(each.value.attach_deny_insecure_transport_policy, false)
  attach_deny_unencrypted_object_uploads     = try(each.value.attach_deny_unencrypted_object_uploads, false)
  attach_elb_log_delivery_policy             = try(each.value.attach_elb_log_delivery_policy, false)
  attach_inventory_destination_policy        = try(each.value.attach_inventory_destination_policy, false)
  attach_lb_log_delivery_policy              = try(each.value.attach_elb_log_delivery_policy, false)
  attach_policy                              = try(each.value.attach_policy, false)
  attach_public_policy                       = try(each.value.attach_public_policy, true)
  attach_require_latest_tls_policy           = try(each.value.attach_require_latest_tls_policy, false)
  block_public_acls                          = try(each.value.block_public_acls, false)
  block_public_policy                        = try(each.value.block_public_policy, false)
  control_object_ownership                   = try(each.value.control_object_ownership, false)
  cors_rule                                  = try(each.value.cors_rule, [])
  create_bucket                              = try(each.value.create_bucket, true)
  expected_bucket_owner                      = try(each.value.expected_bucket_owner, null)
  force_destroy                              = try(each.value.force_destroy, false)
  grant                                      = try(each.value.force_destroy, [])
  ignore_public_acls                         = try(each.value.ignore_public_acls, false)
  intelligent_tiering                        = try(each.value.intelligent_tiering, {})
  inventory_configuration                    = try(each.value.inventory_configuration, {})
  inventory_self_source_destination          = try(each.value.inventory_self_source_destination, false)
  inventory_source_account_id                = try(each.value.inventory_source_account_id, null)
  inventory_source_bucket_arn                = try(each.value.inventory_source_bucket_arn, null)
  lifecycle_rule                             = try(each.value.lifecycle_rule, [])
  logging                                    = try(each.value.logging, {})
  metric_configuration                       = try(each.value.metric_configuration, [])
  object_lock_configuration                  = try(each.value.object_lock_configuration, {})
  object_lock_enabled                        = try(each.value.object_lock_configuration, false)
  object_ownership                           = try(each.value.object_ownership, "ObjectWriter")
  owner                                      = try(each.value.object_ownership, {})
  replication_configuration                  = try(each.value.replication_configuration, {})
  request_payer                              = try(each.value.request_payer, null)
  restrict_public_buckets                    = try(each.value.restrict_public_buckets, false)
  server_side_encryption_configuration       = try(each.value.server_side_encryption_configuration, {})
  tags                                       = try(each.value.tags, {})
  versioning                                 = try(each.value.versioning, {})
  website                                    = try(each.value.website, {})
}
