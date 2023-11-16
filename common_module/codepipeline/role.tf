#######################
# CODEPIPELINE ROLE
#######################
data "aws_iam_policy_document" "code_pipeline_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
      "*"
    ]

    resources = [
      data.aws_s3_bucket.artifact_bucket.arn,
      "${data.aws_s3_bucket.artifact_bucket.arn}/*",
      "*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "codecommit:*"
    ]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["kms:*"]
    resources = [
      data.aws_kms_key.artifact_bucket_kms.arn
    ]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "${local.prefix_name}-pipeline-role"
  assume_role_policy = data.aws_iam_policy_document.code_pipeline_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${local.prefix_name}-pipeline-role-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy_attachment" "CodePipeline_AmazonAministratorAccess" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#######################
# CODEBUID ROLE
#######################
data "aws_iam_policy_document" "code_build_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "code_build_assume_role" {
  name               = "${local.prefix_name}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.code_build_assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "code_build_assume_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      data.aws_s3_bucket.artifact_bucket.arn,
      "${data.aws_s3_bucket.artifact_bucket.arn}/*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["kms:*"]
    resources = [
      data.aws_kms_key.artifact_bucket_kms.arn
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["ecr:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "code_build_assume_role_policy" {
  role   = aws_iam_role.code_build_assume_role.name
  policy = data.aws_iam_policy_document.code_build_assume_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "AmazonAministratorAccess" {
  role       = aws_iam_role.code_build_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

