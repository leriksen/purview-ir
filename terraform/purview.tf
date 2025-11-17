module "purview_account" {
  source = "./modules/purview-account"

  name                = format("%s-%s", "leriksen-purview", random_string.suffix.result)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "purview_mvnet" {
  source = "./modules/purview-managed-vnet"
  depends_on = [
    module.purview_account
  ]
  purview_name       = trimprefix(module.purview_account.scan_endpoint, "https://")
  purview_mvnet_name = "custom_mvnet"
}


resource "time_sleep" "mvnet_wait" {
  depends_on = [
    module.purview_mvnet
  ]
  create_duration = "660s"
}

module "purview_mir" {
  source                      = "./modules/purview-managed-ir"
  purview_endpoint            = local.purview_endpoint
  purview_id                  = module.purview_account.id
  purview_managed_storage     = module.purview_account.managed_resources[0].storage_account_id
  kind                        = "Managed"
  ir_name                     = "MIR"
  mvnet_reference             = module.purview_mvnet.name
}

resource "time_sleep" "mir_wait" {
  depends_on = [
    module.purview_mir
  ]
  create_duration = "660s"
}

# module "purview_adls_pe" {
#   depends_on = [
#     time_sleep.mir_wait
#   ]
#   source           = "./modules/purview-managed-endpoint"
#   purview_endpoint = local.purview_endpoint
#   mvnet_name       = module.purview_mvnet.name
#   name             = "adls"
#   resource_id      = azurerm_storage_account.adls.id
#   resource_kind    = "sa"
#   subresource      = "dfs"
# }
#
# # key vaults have a different schema for representing their PE approval requests....
# module "purview_kv_pe" {
#   depends_on = [
#     time_sleep.mir_wait
#   ]
#   source           = "./modules/purview-managed-endpoint"
#   purview_endpoint = local.purview_endpoint
#   mvnet_name       = module.purview_mvnet.name
#   name             = "kv"
#   resource_id      = azurerm_key_vault.kv.id
#   resource_kind    = "kv"
#   subresource      = "vault"
# }
#
# module "purview_cosmos_pe" {
#   depends_on = [
#     time_sleep.mir_wait
#   ]
#   source           = "./modules/purview-managed-endpoint"
#   purview_endpoint = local.purview_endpoint
#   mvnet_name       = module.purview_mvnet.name
#   name             = "cosmosdb"
#   resource_id      = azurerm_cosmosdb_account.cosmos.id
#   resource_kind    = "cosmosdb"
#   subresource      = "SQL"
# }
#
# module "purview_synapse_pe" {
#   depends_on = [
#     time_sleep.mir_wait
#   ]
#   source           = "./modules/purview-managed-endpoint"
#   purview_endpoint = local.purview_endpoint
#   mvnet_name       = module.purview_mvnet.name
#   name             = "synapse"
#   resource_id      = azurerm_synapse_workspace.synapse.id
#   resource_kind    = "synapse"
#   subresource      = "SqlOnDemand"
# }
