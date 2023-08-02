data "azurerm_client_config" "current" {}

data "azurerm_storage_account_blob_container_sas" "sas_token" {
  connection_string = var.storage_connection_string
  container_name    = var.container_name
  https_only        = true

  start  = "2023-08-02"
  expiry = "2023-08-03"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}

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

resource "azurerm_key_vault_secret" "kv_secret_sas_token" {
  name         = var.sas_secret_name
  value        = data.azurerm_storage_account_blob_container_sas.sas_token.sas
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = [ value ]
  }
}
