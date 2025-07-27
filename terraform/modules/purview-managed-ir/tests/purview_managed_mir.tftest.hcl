run "data" {
  command = apply

  module {
    source = "./modules/data"
  }
}

run "purview_managed_vnet" {
  command = apply

  module {
    source = "./modules/purview-managed-vnet"
  }

  variables {
    purview_name       = run.data.scan_endpoint
    purview_mvnet_name = "custom_vnet"
  }
}

run "test_purview_managed_mir" {
  command = apply

  module {
    source = "../"
  }

  variables {
    purview_id              = run.data.purview_id
    purview_endpoint        = run.data.scan_endpoint
    purview_managed_storage = run.data.purview_managed_storage
    ir_name                 = "MIR"
    mvnet_reference         = "custom_vnet"
  }

  assert {
    condition     = azapi_data_plane_resource.managed_pe != null
    error_message = "invalid purview_managed_endpoint target output"
  }
}

run "test_purview_managed_kv" {
  command = apply

  module {
    source = "../"
  }

  variables {
    name             = "kv"
    purview_endpoint = run.data.scan_endpoint
    mvnet_name       = "custom_vnet"
    resource_id      = run.kv.resource_id
    subresource      = "vault"
    resource_kind    = "kv"
  }

  assert {
    condition     = azapi_data_plane_resource.managed_pe != null
    error_message = "invalid purview_managed_endpoint target output"
  }
}

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
#
# run "test_purview_managed_pe_synapse" {
#   command = apply
#
#   module {
#     source = "../"
#   }
#
#   variables {
#     name             = "synapse"
#     purview_endpoint = run.data.scan_endpoint
#     mvnet_name       = "custom_vnet"
#     resource_id      = run.synapse.resource_id
#     subresource      = "SqlOnDemand"
#     resource_kind    = "synapse"
#   }
#
#   assert {
#     condition     = azapi_data_plane_resource.managed_pe != null
#     error_message = "invalid purview_managed_endpoint target output"
#   }
# }
#