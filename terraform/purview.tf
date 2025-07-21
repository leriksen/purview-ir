module "purview_account" {
  source = "./modules/purview-account"

  name                = format("%s-%s", "leriksen-purview", random_string.suffix.result)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# module "purview_shir" {
#   source = "./modules/purview-ir"
#
#   purview_id = trimprefix(module.purview_account.scan_endpoint, "https://")
#   kind       = "SelfHosted"
#   ir_name    = "SHIR"
# }

module "purview_mvnet" {
  source = "./modules/purview-managed-vnets"
  depends_on = [
    module.purview_account
  ]
  purview_name       = trimprefix(module.purview_account.scan_endpoint, "https://")
  purview_mvnet_name = "defaultv2"
}

output "mvnet" {
  value = module.purview_mvnet.mvnet
}

module "purview_mir" {
  source = "./modules/purview-ir"

  purview_id      = trimprefix(module.purview_account.scan_endpoint, "https://")
  kind            = "Managed"
  ir_name         = "MIR"
  mvnet_reference = module.purview_mvnet.mvnet.name
}

# module "purview_adls_pe" {
#   source        = "./modules/purview-managed-endpoint"
#   mvnet_name    = format("%s/managedvirtualnetworks/%s", trimprefix(module.purview_account.scan_endpoint, "https://"), module.purview_mvnet.name)
#   name          = "adls"
#   resource_id   = azurerm_storage_account.adls.id
#   resource_kind = "sa"
#   subresource   = "dfs"
# }
