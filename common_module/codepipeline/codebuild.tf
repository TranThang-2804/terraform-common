resource "aws_codebuild_project" "this" {
  name           = "${local.prefix_name}-cobuild"
  description    = "code build project for${var.pipeline_description}"
  build_timeout  = "30"
  service_role   = aws_iam_role.code_build_assume_role.arn
  encryption_key = data.aws_kms_key.artifact_bucket_kms.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = templatefile(
      "${path.module}/build-template/buildspec.yaml", {
        "AccountId"           = "${local.account_id}",
        "RegionId"            = "${data.aws_region.current.name}"
        "ECR_Name"            = "${aws_ecr_repository.this.name}"
        "App_Folder"          = "${var.app_folder}"
        "Helm_Image_Tag_Path" = "${var.helm_image_tag_path}"
        "Helm_Image_Uri_Path" = "${var.helm_image_uri_path}"
        "BUILD_COMMAND"       = "${var.build_command}"
      }
    )
  }

  cache {
    type     = "S3"
    location = "${data.aws_s3_bucket.artifact_bucket.bucket}/cache"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? var.vpc_config : []
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
      vpc_id             = vpc_config.value.vpc_id
    }
  }

  tags = var.tags
}