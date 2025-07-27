# these take a lot of time to run, we will hard code while we do local development

# run "rg_provider" {
#   command = apply
#
#   module {
#     source = "./modules/rg"
#   }
#
#   variables {
#     name     = "purview-managed-vnet-tftest"
#     location = "australiaeast"
#   }
# }
#
# run "purview_account_provider" {
#   command = apply
#
#   module {
#     source = "./modules/purview-account"
#   }
#
#   variables {
#     name                = "purview-account-tftest"
#     resource_group_name = run.rg_provider.rg.name
#     location            = run.rg_provider.rg.location
#   }
# }

run "test_purview_managed_vnet" {
  command = apply

  module {
    source = "../"
  }

  variables {


    # purview_name       = trimprefix(run.purview_account_provider.scan_endpoint, "https://")
    purview_name       = trimprefix("https://leriksen-purview-uwou.purview.azure.com/scan", "https://")
    purview_mvnet_name = "custom_vnet"
  }

  assert {
    condition     = azapi_data_plane_resource.mvnet.name == "custom_vnet"
    error_message = "invalid purview_managed_vnet target output"
  }
}
