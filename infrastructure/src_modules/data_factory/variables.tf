variable "adf_name" {
  type        = string
  description = "Data Factory name."
}

variable "resource_grp_name" {
  type        = string
  description = "Resource group name."
}

variable "location_name" {
  type        = string
  description = "Name of the geolocation."
}

//variable "github_account_name" {
//  type        = string
//  description = "GitHub account name."
//}
//
//variable "branch_name" {
//  type = string
//  description = "Specifies the branch of the repository to get code from"
//  default = "main"
//}
//
//variable "repository_name" {
//  type = string
//  description = "GitHub repository name"
//}
//
//variable "root_folder" {
//  type = string
//  description = "Specifies the root folder within the GitHub repository"
//}

variable "global_parameters" {
  type = list(map(string))
  description = "A dictionary with global parameters of string type"
}

variable "tags" {
  type = map(string)
  description = "List of tags"
}