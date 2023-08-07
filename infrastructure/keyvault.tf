data "azurerm_storage_account_blob_container_sas" "sas_token_data_extracts" {
  connection_string = module.demo_storage_acc.storage_account_con_string
  container_name    = local.data_extracts_container
  https_only        = true

  start  = local.sas_token_start
  expiry = local.sas_token_expiry

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
  depends_on          = [module.demo_storage_acc, module.keyvault]
}

module "keyvault" {
  source                    = "./src_modules/key_vault"
  keyvault_name             = local.key_vault_name
  resource_grp_name         = module.demo_rg_group.resource_group_name
  location_name             = module.demo_rg_group.resource_group_location
  secrets_list              = local.key_vault_secrets
  adf_object_id             = module.adf.adf_object_id
  tags                      = var.tags
  depends_on                = [module.demo_rg_group, module.adf, module.demo_storage_acc]
}

resource "azurerm_key_vault_secret" "kv_secret_sas_token" {
  name         = local.sas_token_data_extracts
  value        = data.azurerm_storage_account_blob_container_sas.sas_token_data_extracts.sas
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.keyvault]
}

resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "kv_secret_sql_password" {
  name         = local.sql_pass_secret
  value        = random_password.sql_password.result
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.keyvault]
}

resource "azurerm_key_vault_secret" "kv_secret_sql_conn_str" {
  name         = local.sql_conn_str
  value        = module.sql_db_demo.sql_db_conn_string
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.keyvault, module.sql_db_demo]
}