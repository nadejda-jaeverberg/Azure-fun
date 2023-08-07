output "sql_server_id" {
  value = azurerm_mssql_server.sql_server.id
}

output "sql_db_conn_string" {
  description = "Connection string for the Azure SQL Database created."
  sensitive   = true
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sql_server.administrator_login};Password=${azurerm_mssql_server.sql_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}