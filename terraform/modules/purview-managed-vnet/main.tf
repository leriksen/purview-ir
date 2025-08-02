resource azapi_data_plane_resource "mvnet" {
  name      = var.purview_mvnet_name
  parent_id = var.purview_name
  type      = "Microsoft.Purview/accounts/Scanning/managedvirtualnetworks@2023-09-01"

  body = {
    properties = {}
  }

  delete_query_parameters = {
    recursive = tolist(["true"])
  }

  response_export_values = ["*"]
}

resource time_sleep mvnet_provisioning {
  depends_on = [
    azapi_data_plane_resource.mvnet
  ]

  create_duration = var.create_duration
}
