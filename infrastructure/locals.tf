locals {
  data_extracts_container = "data-extracts"

  key_vault_name = "${var.environment}keyvaultdemo"
  key_vault_secrets = ["demoPass"]
  key_vault_sas_secret = "connectionString"

  adf_name = "${var.environment}datafactorydemouknj"
  global_parameters = [
    { name = "storageaccount", value = module.demo_storage_acc.storage_account_name, type = "String" },
    { name = "datacontainer", value = local.data_extracts_container, type = "String" }
  ]

  github_account_name = "nadejda-jaeverberg"
  branch_name = "main"
  repository_name = "Azure-fun"
  root_folder = "adf_code"

  demo_resource_grp_name = "${upper(var.environment)}myDemoResourceGroup"
  demo_location = "UK South"
  demo_st_acc_name = "stdemoaccountname"
  demo_containers = [local.data_extracts_container]
}
