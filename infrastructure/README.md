# Terraforming infrastructure

## Exporting storage account key
* export ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
* echo $ACCOUNT_KEY