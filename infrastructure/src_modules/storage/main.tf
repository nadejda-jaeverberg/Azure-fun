resource "azurerm_storage_account" "st_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_grp_name
  location                 = var.location_name
  account_tier             = var.account_tier
  account_replication_type = "GRS"

  tags = var.tags
}

resource "azurerm_storage_container" "st_container" {
  for_each              = toset( var.container_list )
  name                  = each.key
  storage_account_name  = azurerm_storage_account.st_account.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.st_account]
}
