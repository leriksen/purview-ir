resource "azurerm_resource_group" "rg" {
  location = module.globals.location
  name     = format("%s-%s", "purview", random_string.suffix.result)
}