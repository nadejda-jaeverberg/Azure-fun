resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location_name
  resource_group_name = var.resource_grp_name
//  github_configuration = {
//    account_name    = var.github_account_name
//    branch_name     = var.branch_name
//    git_url         = "https://github.com"
//    repository_name = var.repository_name
//    root_folder     = var.root_folder
//  }
  dynamic "global_parameter" {
    for_each     = var.global_parameters
    content {
      name         = global_parameter.value.name
      type         = global_parameter.value.type
      value        = global_parameter.value.value
    }
  }
  tags           = var.tags
}