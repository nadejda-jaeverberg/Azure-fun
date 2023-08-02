output "storage_account_name" {
  value = azurerm_storage_account.st_account.name
}

output "storage_account_id" {
  value = azurerm_storage_account.st_account.id
}

output "storage_account_url" {
  value = azurerm_storage_account.st_account.primary_dfs_endpoint
}

output "storage_account_blob_url" {
  value = azurerm_storage_account.st_account.primary_blob_endpoint
}

output "storage_account_con_string" {
  value = azurerm_storage_account.st_account.primary_connection_string
}