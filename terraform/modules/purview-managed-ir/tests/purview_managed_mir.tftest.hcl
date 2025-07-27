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
    condition     = azapi_data_plane_resource.mir.output.kind == "Managed"
    error_message = "invalid purview_managed_endpoint target output"
  }
}

# even though the test has finished we need to wait for the MIR to stop provisioning before tearing it down
run "delay_mir_provisioning" {
  command = apply

  module {
    source = "./modules/delay"
  }

  variables {
    create_duration = "600s"
  }
}
