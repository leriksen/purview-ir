resource "azurerm_key_vault" "kv" {
  name                     = format("%s%s", "lepurviewkv01", "uwou")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku_name                 = "standard"
  tenant_id                = var.tenant_id
}