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

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "link-adf-adls" {
  name                  = "LS-adf-to-adls"
  data_factory_id       = module.adf.adf_id
  use_managed_identity  = true
  url                   = module.demo_storage_acc.storage_account_url
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "link-adf-blob" {
  name            = "LS-adf-to-blob"
  data_factory_id = module.adf.adf_id

  sas_uri = "${module.demo_storage_acc.storage_account_blob_url}${local.data_extracts_container}"
  key_vault_sas_token {
    linked_service_name = azurerm_data_factory_linked_service_key_vault.link-adf-keyvault.name
    secret_name         = "connectionString"
  }
}