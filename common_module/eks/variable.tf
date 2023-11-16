variable "global_variables" {
  type = any
}

variable "module_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "eks_log_retention_in_days" {
  type = number
}

variable "enabled_cluster_log_types" {
  type = list(string)
}

variable "scaling_config" {
  type = map(any)
}

variable "capacity_type" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "max_unavailable" {
  type = number
}

variable "tags" {
  type = any
}

variable "addons" {
  type    = list(any)
  default = ["vpc-cni", "coredns", "kube-proxy", "aws-ebs-csi-driver"]
}

variable "az_count" {
  type    = number
  default = 2
}