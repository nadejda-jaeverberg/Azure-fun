module "keyvault" {
  source                    = "./src_modules/key_vault"
  keyvault_name             = local.key_vault_name
  resource_grp_name         = module.demo_rg_group.resource_group_name
  location_name             = module.demo_rg_group.resource_group_location
  secrets_list              = local.key_vault_secrets
  adf_object_id             = module.adf.adf_object_id
  storage_connection_string = module.demo_storage_acc.storage_account_con_string
  container_name            = local.data_extracts_container
  sas_secret_name           = local.key_vault_sas_secret
  tags                      = var.tags
  depends_on                = [module.demo_rg_group, module.adf, module.demo_storage_acc]
}