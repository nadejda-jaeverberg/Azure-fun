locals {
  adf_name = "${var.environment}datafactorydemouknj"
  global_parameters = [
    { name = "storageaccount", value = module.demo_storage_acc.storage_account_name, type = "String" },
    { name = "datacontainer", value = "data-extracts", type = "String" }
  ]
}

module "adf" {
  source            = "./src_modules/data_factory"
  adf_name          = local.adf_name
  resource_grp_name = module.demo_rg_group.resource_group_name
  location_name     = module.demo_rg_group.resource_group_location
  global_parameters = local.global_parameters
  tags              = var.tags
  depends_on        = [module.demo_rg_group]
}

resource "azurerm_data_factory_linked_service_key_vault" "link-adf-keyvault" {
  name                     = "LS-adf-to-keyvault"
  data_factory_id          = module.adf.adf_id
  key_vault_id             = module.keyvault.key_vault_id
  integration_runtime_name = module.adf.adf_runtime_name
}