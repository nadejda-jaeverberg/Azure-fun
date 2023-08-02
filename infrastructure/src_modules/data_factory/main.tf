resource "azurerm_data_factory" "adf" {
  name                            = var.adf_name
  location                        = var.location_name
  resource_group_name             = var.resource_grp_name
  managed_virtual_network_enabled = true
//  public_network_enabled          = false
  github_configuration {
    account_name    = var.github_account_name
    branch_name     = var.branch_name
    git_url         = "https://github.com"
    repository_name = var.repository_name
    root_folder     = var.root_folder
  }
  identity {
    type = "SystemAssigned"
  }
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

resource "azurerm_data_factory_integration_runtime_azure" "az_runtime" {
  name                    = "AutoResolveIntegrationRuntime"
  data_factory_id         = azurerm_data_factory.adf.id
  location                = "AutoResolve"
  virtual_network_enabled = true
  time_to_live_min        = 0
}