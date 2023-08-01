locals {
  adf_name = "${var.environment}datafactory"
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