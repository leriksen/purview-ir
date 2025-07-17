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

output "mvnets" {
  value = module.purview_mvnet.values
}

output "mvnet_name" {
  value = module.purview_mvnet.values.name
}