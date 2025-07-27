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

run "adls" {
  command = apply

  module {
    source = "./modules/adls"
  }

  variables {
    resource_group_name = run.data.resource_group_name
    location            = run.data.location
  }
}

run "test_purview_managed_pe_adls" {
  command = apply

  module {
    source = "../"
  }

  variables {
    name             = "adls"
    purview_endpoint = run.data.scan_endpoint
    mvnet_name       = "custom_vnet"
    resource_id      = run.adls.resource_id
    subresource      = "dfs"
    resource_kind    = "sa"
  }

  assert {
    condition     = azapi_data_plane_resource.managed_pe != null
    error_message = "invalid purview_managed_endpoint target output"
  }
}
