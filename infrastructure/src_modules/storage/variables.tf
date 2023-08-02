variable "storage_account_name" {
  type        = string
  description = "Storage account name."
}

variable "resource_grp_name" {
  type        = string
  description = "Resource group name."
}

variable "location_name" {
  type        = string
  description = "Name of the geolocation."
}

variable "account_tier" {
  type = string
  description = "Account tier for storage account"
}

variable "container_list" {
  type = list
  description = "List of container names"
}

variable "tags" {
  type = map(string)
  description = "List of tags"
}