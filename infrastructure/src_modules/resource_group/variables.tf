variable "resource_grp_name" {
  type        = string
  description = "Resource group name."
}

variable "location_name" {
  type        = string
  description = "Name of the geolocation."
}

variable "tags" {
  type = map(string)
  description = "List of tags"
}