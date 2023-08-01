output "adf_id" {
  value = azurerm_data_factory.adf.id
}

output "adf_runtime_name" {
  value = azurerm_data_factory_integration_runtime_azure.az_runtime.name
}