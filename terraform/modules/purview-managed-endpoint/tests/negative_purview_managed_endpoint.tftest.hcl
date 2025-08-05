# run "data" {
#   command = apply
#
#   module {
#     source = "./modules/data"
#   }
# }
#
# run "purview_managed_vnet" {
#   command = apply
#
#   module {
#     source = "./modules/purview-managed-vnet"
#   }
#
#   variables {
#     purview_name       = run.data.scan_endpoint
#     purview_mvnet_name = "custom_vnet"
#   }
# }
#
# run "adls" {
#   command = apply
#
#   module {
#     source = "./modules/adls"
#   }
#
#   variables {
#     resource_group_name = run.data.resource_group_name
#     location            = run.data.location
#   }
# }
#
# run "kv" {
#   command = apply
#
#   module {
#     source = "./modules/kv"
#   }
#
#   variables {
#     resource_group_name = run.data.resource_group_name
#     location            = run.data.location
#     tenant_id           = run.data.config.tenant_id
#   }
# }
#
# run "cosmosdb" {
#   command = apply
#
#   module {
#     source = "./modules/cosmosdb"
#   }
#
#   variables {
#     resource_group_name = run.data.resource_group_name
#     location            = run.data.location
#   }
# }
#
# run "synapse" {
#   command = apply
#
#   module {
#     source = "./modules/synapse"
#   }
#
#   variables {
#     resource_group_name = run.data.resource_group_name
#     location            = run.data.location
#     adls_id             = run.adls.resource_id
#   }
# }
#
# run "test_purview_managed_pe_adls" {
#   command = apply
#
#   module {
#     source = "../"
#   }
#
#   variables {
#     name             = "adls"
#     purview_endpoint = run.data.scan_endpoint
#     mvnet_name       = "custom_vnet"
#     resource_id      = run.adls.resource_id
#     subresource      = "dfs"
#     resource_kind    = "sa"
#   }
#
#   assert {
#     condition     = azapi_data_plane_resource.managed_pe != null
#     error_message = "invalid purview_managed_endpoint target output"
#   }
# }
#
# run "test_purview_managed_kv" {
#   command = apply
#
#   module {
#     source = "../"
#   }
#
#   variables {
#     name             = "kv"
#     purview_endpoint = run.data.scan_endpoint
#     mvnet_name       = "custom_vnet"
#     resource_id      = run.kv.resource_id
#     subresource      = "vault"
#     resource_kind    = "kv"
#   }
#
#   assert {
#     condition     = azapi_data_plane_resource.managed_pe != null
#     error_message = "invalid purview_managed_endpoint target output"
#   }
# }
#
# run "test_purview_managed_pe_cosmosdb" {
#   command = apply
#
#   module {
#     source = "../"
#   }
#
#   variables {
#     name             = "cosmosdb"
#     purview_endpoint = run.data.scan_endpoint
#     mvnet_name       = "custom_vnet"
#     resource_id      = run.cosmosdb.resource_id
#     subresource      = "SQL"
#     resource_kind    = "cosmosdb"
#   }
#
#   assert {
#     condition     = azapi_data_plane_resource.managed_pe != null
#     error_message = "invalid purview_managed_endpoint target output"
#   }
# }

run "test_purview_managed_pe_synapse" {
  command = plan

  module {
    source = "../"
  }

  variables {
    name             = "doesnt_matter"
    purview_endpoint = "doesnt_matter"
    mvnet_name       = "doesnt_matter"
    resource_id      = "doesnt_matter"
    subresource      = "Wrong"
    resource_kind    = "sa"
  }

  expect_failures = [
    var.subresource
  ]
}
