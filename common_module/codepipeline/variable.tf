variable "global_variables" {
  type = any
}

variable "module_name" {
  type = string
}

variable "pipeline_description" {
  type = string
}

variable "artifact_bucket" {
  type = string
}

variable "artifact_bucket_kms_key_id" {
  type = string
}

variable "vpc_config" {
  type = any
}

variable "aws_codestarconnections_connection_name" {
  type = string
}

variable "helm_deploy_build_name" {
  type = string
}

variable "app_folder" {
  type = string
}

variable "repo_owner" {
  type = string
}

variable "repo_name" {
  type = string
}

variable "helm_image_tag_path" {
  type = string
}

variable "helm_image_uri_path" {
  type = string
}

variable "tags" {
  type = any
}

variable "build_command" {
  type    = string
  default = "- mvn clean package"
}
