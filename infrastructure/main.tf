data "azurerm_key_vault_secret" "kvsecret_sql_pass" {
  name         = local.sql_pass_secret
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.keyvault]
}

module "demo_rg_group" {
  source            = "./src_modules/resource_group"
  resource_grp_name = local.demo_resource_grp_name
  location_name     = local.demo_location
  tags              = var.tags
}

module "demo_storage_acc" {
  source               = "./src_modules/storage"
  storage_account_name = local.demo_st_acc_name
  resource_grp_name    = local.demo_resource_grp_name
  location_name        = local.demo_location
  account_tier         = "Standard"
  container_list       = local.demo_containers
  tags                 = var.tags
  depends_on           = [module.demo_rg_group]
}

resource "azurerm_role_assignment" "adf_data_contributor" {
  scope                = module.demo_storage_acc.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.adf.adf_object_id
}

module "sql_db_demo" {
  source              = "./src_modules/sql_db"
  sql_server_name     = "${lower(var.environment)}-demo-sql-server"
  sql_db_name         = "${lower(var.environment)}-demo-sql-db"
  resource_group_name = module.demo_rg_group.resource_group_name
  geo_location        = module.demo_rg_group.resource_group_location
  admin_name          = "myAdminName"
  admin_pass          = data.azurerm_key_vault_secret.kvsecret_sql_pass.value
  tags                = var.tags
  depends_on          = [module.demo_rg_group, module.keyvault]
}
