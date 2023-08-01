resource "azurerm_data_factory_managed_private_endpoint" "adf-blob-pe" {
  name               = "adf-blob"
  data_factory_id    = module.adf.adf_id
  target_resource_id = module.demo_storage_acc.storage_account_id
  subresource_name   = "blob"
  depends_on         = [module.demo_rg_group, module.adf, module.demo_storage_acc]
}

resource "azurerm_data_factory_managed_private_endpoint" "adf-dfs-pe" {
  name               = "adf-dfs"
  data_factory_id    = module.adf.adf_id
  target_resource_id = module.demo_storage_acc.storage_account_id
  subresource_name   = "dfs"
  depends_on         = [module.demo_rg_group, module.adf, module.demo_storage_acc]
}

resource "azurerm_data_factory_managed_private_endpoint" "adf-vault-pe" {
  name               = "adf-vault"
  data_factory_id    = module.adf.adf_id
  target_resource_id = module.keyvault.key_vault_id
  subresource_name   = "vault"
  depends_on         = [module.demo_rg_group, module.adf, module.demo_storage_acc]
}