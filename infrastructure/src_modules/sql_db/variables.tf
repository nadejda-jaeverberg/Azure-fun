variable "sql_server_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "geo_location" {
  type = string
}

variable "sql_server_version" {
  type = string
  default = "12.0"
}

variable "admin_name" {
  type = string
}

variable "admin_pass" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "tags" {
  type = map(string)
}