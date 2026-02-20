  resource "azurerm_key_vault" "kv" {
    name                     = format("%s%s", "lepurviewkv01", random_string.suffix.result)
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    sku_name                 = "standard"
    tenant_id                = data.azurerm_client_config.current.tenant_id
  }