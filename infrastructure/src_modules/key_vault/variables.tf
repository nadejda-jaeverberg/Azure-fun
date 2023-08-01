variable "keyvault_name" {
  type        = string
  description = "Key vault name."
}

variable "resource_grp_name" {
  type        = string
  description = "Resource group name."
}

variable "location_name" {
  type        = string
  description = "Name of the geolocation."
}

variable "secrets_list" {
  type = list
  description = "List of secret names in key vault"
}

variable "adf_object_id" {
  type = string
}

variable "tags" {
  type = map(string)
  description = "List of tags"
}