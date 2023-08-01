locals {
  demo_resource_grp_name = "${upper(var.environment)}myDemoResourceGroup"
  demo_location = "UK South"
  demo_st_acc_name = "stdemoaccountname"
  demo_containers = ["data-extracts"]
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