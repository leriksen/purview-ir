module "purview_account" {
  source = "./modules/purview-account"

  name                = "leriksen-purview"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "purview_ir" {
  source = "./modules/purview-ir"

  purview_id = trimprefix(module.purview_account.scan_endpoint, "https://")
  kind       = "SelfHosted"
}

output ir_name {
  value = module.purview_ir.name
}

output ir_id {
  value = module.purview_ir.id
}

output ir_properties {
  value = module.purview_ir.properties
}
