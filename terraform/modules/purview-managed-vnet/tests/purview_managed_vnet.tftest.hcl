run "data" {
  command = apply

  module {
    source = "./modules/data"
  }
}

run "test_purview_managed_vnet" {
  command = apply

  module {
    source = "../"
  }

  variables {


    purview_name       = run.data.scan_endpoint
    purview_mvnet_name = "custom_vnet"
  }

  assert {
    condition     = azapi_data_plane_resource.mvnet.name == "custom_vnet"
    error_message = "invalid purview_managed_vnet target output"
  }
}
