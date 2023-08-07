resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.geo_location
  version                      = var.sql_server_version
  administrator_login          = var.admin_name
  administrator_login_password = var.admin_pass
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 100
  read_scale     = false
  sku_name       = "S0"
  tags           = var.tags
}