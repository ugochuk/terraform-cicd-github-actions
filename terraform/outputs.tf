output "resource_group_name" {
  description = "Name of the deployed resource group."
  value       = azurerm_resource_group.this.name
}

output "storage_account_name" {
  description = "Name of the deployed storage account."
  value       = azurerm_storage_account.this.name
}
