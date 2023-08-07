data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.location_name
  resource_group_name         = var.resource_grp_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"

  tags     = var.tags
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
  access_policy {
    object_id = var.adf_object_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get",
      "List"
    ]

//    storage_permissions = []
  }
}

resource "azurerm_key_vault_secret" "kv_secret" {
  for_each     = toset( var.secrets_list )
  name         = each.key
  value        = "Value not set"
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = [ value ]
  }
}
