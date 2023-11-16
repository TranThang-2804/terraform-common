data "aws_s3_bucket" "artifact_bucket" {
  bucket = var.artifact_bucket
}

data "aws_kms_key" "artifact_bucket_kms" {
  key_id = var.artifact_bucket_kms_key_id
}

locals {
  prefix_name = "${var.global_variables["project"]}-${var.global_variables["owner"]}-${var.global_variables["environment"]}-${var.module_name}"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_region" "current" {}

data "aws_codestarconnections_connection" "this" {
  name = var.aws_codestarconnections_connection_name
}