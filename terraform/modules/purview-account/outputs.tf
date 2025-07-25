output "name" {
  value = azurerm_purview_account.account.name
}

output "id" {
  value = azurerm_purview_account.account.id
}

output "scan_endpoint" {
  value = azurerm_purview_account.account.scan_endpoint
}

output "managed_resources" {
  value = azurerm_purview_account.account.managed_resources
}