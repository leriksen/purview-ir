resource "azurerm_storage_account" "adls" {
  name                     = format("%s%s", "lepurviewadls01", random_string.suffix.result)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}