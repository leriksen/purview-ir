resource "azurerm_resource_group" "rg" {
  location = module.globals.location
  name     = format("%s-%s", "purview", random_string.suffix.result)
}

resource "azurerm_role_assignment" "sp" {
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "User Access Administrator"
}
