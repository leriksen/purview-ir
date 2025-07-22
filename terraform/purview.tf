module "purview_account" {
  source = "./modules/purview-account"

  name                = format("%s-%s", "leriksen-purview", random_string.suffix.result)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "purview_mvnet" {
  source = "./modules/purview-managed-vnets"
  depends_on = [
    module.purview_account
  ]
  purview_name       = trimprefix(module.purview_account.scan_endpoint, "https://")
  purview_mvnet_name = "custom_mvnet"
}

resource "time_sleep" "wait" {
  depends_on = [
    module.purview_mvnet
  ]
  create_duration = "120s"
}

module "purview_mir" {
  source = "./modules/purview-ir"

  depends_on = [
    time_sleep.wait
  ]

  purview_id      = trimprefix(module.purview_account.scan_endpoint, "https://")
  kind            = "Managed"
  ir_name         = "MIR"
  mvnet_reference = module.purview_mvnet.mvnet.name
}

module "purview_adls_pe" {
  source           = "./modules/purview-managed-endpoint"
  purview_endpoint = trimprefix(module.purview_account.scan_endpoint, "https://")
  mvnet_name       = module.purview_mvnet.mvnet.name
  name             = "adls"
  resource_id      = azurerm_storage_account.adls.id
  resource_kind    = "sa"
  subresource      = "dfs"
}

output "managed_pe" {
  value = module.purview_adls_pe.managed_pe
}

output "managed_resources" {
  value = module.purview_account.managed_resources
}