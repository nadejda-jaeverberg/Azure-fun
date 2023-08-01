# Terraforming infrastructure

## Exporting storage account key
* export ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
* echo $ACCOUNT_KEY

## Registering providers
az provider register --namespace "Microsoft.DataFactory"

To see progress: az provider show -n Microsoft.DataFactory

URL: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types

## Plan and Apply commands

terraform plan  -var-file="env/dev.tfvars"

terraform apply  -var-file="env/dev.tfvars"

## Useful links
* Azure tutorial: https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build

* Azure terraform: https://techcommunity.microsoft.com/t5/azure-architecture-blog/terraform-locally-run-from-windows-with-state-file-in-azure/ba-p/3637692

* Terraform dynamic blocks: https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks

* Terraform documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources
