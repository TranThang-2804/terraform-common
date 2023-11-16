variable "module_name" {
  type = string
}

variable "global_variables" {
  type = any
}

variable "read_capacity" {
  type = string
}

variable "write_capacity" {

}

variable "hash_key" {

}

variable "table_attribute" {
  type = any
}

variable "ttl_attribute_name" {
  type = string
}

variable "ttl_enabled" {
  type = bool
}

variable "tags" {
  type = any
}
