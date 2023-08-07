locals {
  data_extracts_container = "data-extracts"
  configs_container = "configs"

  key_vault_name = "${var.environment}keyvaultdemo"
  key_vault_secrets = ["demoPass"]
  sas_token_data_extracts = "connectionString"
  sql_pass_secret = "sqldbpass"
  sql_conn_str = "sqlconnstr"

  sas_token_start  = "2023-08-08"
  sas_token_expiry = "2023-08-10"

  adf_name = "${var.environment}datafactorydemouknj"
  global_parameters = [
    { name = "storageaccount", value = module.demo_storage_acc.storage_account_name, type = "String" },
    { name = "datacontainer", value = local.data_extracts_container, type = "String" },
    { name = "configcontainer", value = local.configs_container, type = "String" }
  ]

  github_account_name = "nadejda-jaeverberg"
  branch_name = "main"
  repository_name = "Azure-fun"
  root_folder = "adf_code"

  demo_resource_grp_name = "${upper(var.environment)}myDemoResourceGroup"
  demo_location = "UK South"
  demo_st_acc_name = "stdemoaccountname"
  demo_containers = [local.data_extracts_container, local.configs_container]
}
