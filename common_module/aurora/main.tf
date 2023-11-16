locals {
  password = "postgres"
}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 7.0.0"

  vpc_id                              = var.vpc_id
  db_subnet_group_name                = "${local.prefix_name}-db-sg"
  subnets                             = var.private_subnet_ids
  allowed_cidr_blocks                 = var.cidr_blocks
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  master_username        = var.master_username
  master_password        = local.password
  database_name          = var.database_name
  create_random_password = false

  apply_immediately   = var.apply_immediately == null ? true : var.apply_immediately
  skip_final_snapshot = var.skip_final_snapshot == null ? false : var.skip_final_snapshot

  name           = local.prefix_name
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.instance_class == null ? "db.t3.large" : var.instance_class

  instances = var.instances

  autoscaling_enabled      = var.autoscaling_enabled == null ? false : var.autoscaling_enabled
  autoscaling_min_capacity = var.autoscaling_enabled == null ? 0 : var.autoscaling_min_capacity
  autoscaling_max_capacity = var.autoscaling_enabled == null ? 0 : var.autoscaling_max_capacity

  storage_encrypted = var.storage_encrypted == null ? true : var.storage_encrypted

  monitoring_interval           = var.monitoring_interval == null ? 10 : var.monitoring_interval
  iam_role_name                 = "${local.prefix_name}auroramonitor"
  iam_role_use_name_prefix      = true
  iam_role_description          = "${local.prefix_name}-aurora enhanced monitoring IAM role"
  iam_role_path                 = "/autoscaling/"
  iam_role_max_session_duration = var.iam_role_max_session_duration == null ? 7200 : var.iam_role_max_session_duration

  enabled_cloudwatch_logs_exports = ["postgresql"]
  tags                            = var.tags
}


#SSM
resource "aws_ssm_parameter" "default_ssm_parameter_identifier" {
  name      = format("/rds/db/%s/identifier", local.prefix_name)
  value     = module.aurora.cluster_database_name
  type      = "String"
  overwrite = true
}

resource "aws_ssm_parameter" "default_ssm_parameter_endpoint" {
  name      = format("/rds/db/%s/endpoint", local.prefix_name)
  value     = module.aurora.cluster_endpoint
  type      = "String"
  overwrite = true
}

resource "aws_ssm_parameter" "default_ssm_parameter_endpoint_reader" {
  name      = format("/rds/db/%s/endpoint_reader", local.prefix_name)
  value     = module.aurora.cluster_reader_endpoint
  type      = "String"
  overwrite = true
}
resource "aws_ssm_parameter" "default_postgres_ssm_parameter_username" {
  name      = format("/rds/db/%s/superuser/username", local.prefix_name)
  value     = module.aurora.cluster_master_username
  type      = "String"
  overwrite = true
}

resource "aws_ssm_parameter" "default_ssm_parameter_password" {
  name      = format("/rds/db/%s/superuser/password", local.prefix_name)
  value     = module.aurora.cluster_master_password
  type      = "String"
  overwrite = true
}
resource "aws_ssm_parameter" "default_db_name" {
  name      = format("/rds/db/%s/dbname", local.prefix_name)
  value     = module.aurora.cluster_database_name
  type      = "String"
  overwrite = true
}
