locals {
  key_vault_name = "${var.environment}keyvaultdemo"
  key_vault_secrets = ["connectionString", "demoPass"]

  adf_name = "${var.environment}datafactorydemouknj"
  global_parameters = [
    { name = "storageaccount", value = module.demo_storage_acc.storage_account_name, type = "String" },
    { name = "datacontainer", value = "data-extracts", type = "String" }
  ]

  demo_resource_grp_name = "${upper(var.environment)}myDemoResourceGroup"
  demo_location = "UK South"
  demo_st_acc_name = "stdemoaccountname"
  demo_containers = ["data-extracts"]
}
