variable "global_variables" {
  type = any
}

variable "module_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "private_subnet_cidr_blocks" {
  type = set(string)
}

variable "public_subnet_cidr_blocks" {
  type = set(string)
}

variable "availability_zones" {
  type = set(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "tags" {
  type = any
}
