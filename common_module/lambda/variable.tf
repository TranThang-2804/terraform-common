variable "global_variables" {
  type = any
}

variable "module_name" {
  type = string
}

variable "source_file" {
  type = string
}

variable "zip_file_path" {
  type = string
}

variable "runtime" {
  type = string
}

variable "tags" {
  type = any
}

variable "enable_url" {
  type    = bool
  default = false
}

variable "handler" {
  type    = string
  default = "index.handler"
}
