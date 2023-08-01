locals {
  secrets = ["connectionString", "demoPass"]
}
module "keyvault" {
  source            = "./src_modules/key_vault"
  keyvault_name     = local.key_vault_name
  resource_grp_name = module.demo_rg_group.resource_group_name
  location_name     = module.demo_rg_group.resource_group_location
  secrets_list      = local.secrets
  tags              = var.tags
  depends_on        = [module.demo_rg_group]
}