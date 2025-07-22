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

  purview_endpoint        = trimprefix(module.purview_account.scan_endpoint, "https://")
  purview_id              = module.purview_account.id
  purview_managed_storage = module.purview_account.managed_resources[0].storage_account_id
  kind                    = "Managed"
  ir_name                 = "MIR"
  mvnet_reference         = module.purview_mvnet.mvnet.name
}

output "mir_output" {
  value = module.purview_mir.result
}

output "account_managed_pe" {
  value = module.purview_mir.account_managed_pe
}

output "storage_blob_managed_pe" {
  value = module.purview_mir.storage_blob_managed_pe
}

output "storage_queue_managed_pe" {
  value = module.purview_mir.storage_queue_managed_pe
}

output account_data {
  value = module.purview_mir.account_data_azapi_resource_pe
}

output storage_blob {
  value = module.purview_mir.storage_blob_data_azapi_resource_pe
}

output storage_queue {
  value = module.purview_mir.storage_queue_data_azapi_resource_pe
}

# output "approved_account_managed_pe" {
#   value = module.purview_mir.approved_account_managed_pe
# }
#
# output "approved_storage_blob_managed_pe" {
#   value = module.purview_mir.approved_storage_blob_managed_pe
# }
#
# output "approved_storage_queue_managed_pe" {
#   value = module.purview_mir.approved_storage_queue_managed_pe
# }

# module "purview_adls_pe" {
#   source           = "./modules/purview-managed-endpoint"
#   purview_endpoint = trimprefix(module.purview_account.scan_endpoint, "https://")
#   mvnet_name       = module.purview_mvnet.mvnet.name
#   name             = "adls"
#   resource_id      = azurerm_storage_account.adls.id
#   resource_kind    = "sa"
#   subresource      = "dfs"
# }
#
# output "managed_pe" {
#   value = module.purview_adls_pe.managed_pe
# }
