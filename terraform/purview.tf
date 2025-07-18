module "purview_account" {
  source = "./modules/purview-account"

  name                = "leriksen-purview"
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
#
# module "purview_mir" {
#   source = "./modules/purview-ir"
#
#   purview_id = trimprefix(module.purview_account.scan_endpoint, "https://")
#   kind       = "Managed"
#   ir_name    = "MIR"
# }

module "purview_mvnet" {
  source = "./modules/purview-managed-vnets"

  purview_name      = module.purview_account.name
  arm_tenant_id     = var.arm_tenant_id
  arm_client_id     = var.arm_client_id
  arm_client_secret = var.arm_client_secret
}

module "purview_adls_pe" {
  source        = "./modules/purview-managed-endpoint"
  mvnet_name    = format("%s/managedvirtualnetworks/%s", trimprefix(module.purview_account.scan_endpoint, "https://"), module.purview_mvnet.name)
  name          = "adls"
  resource_id   = azurerm_storage_account.adls.id
  resource_kind = "sa"
  subresource   = "dfs"
}
