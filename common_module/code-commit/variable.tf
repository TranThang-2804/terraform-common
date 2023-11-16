variable "repository_name" {
  type        = string
  description = "name of the repository"
}

variable "description" {
  type        = string
  description = "the description of the repo"
}

variable "tags" {
  type = any
}