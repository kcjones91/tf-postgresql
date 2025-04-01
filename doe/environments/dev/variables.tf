variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "env" {
  type = string
}

variable "db_admin" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
