resource azapi_data_plane_resource "mvnet" {
  name      = var.purview_mvnet_name
  parent_id = var.purview_name
  type      = "Microsoft.Purview/accounts/Scanning/managedvirtualnetworks@2023-09-01"

  body = {
    properties = {}
  }

  response_export_values = ["*"]
}

resource "time_sleep" "wait" {
  depends_on = [
    azapi_data_plane_resource.mvnet
  ]
  create_duration = "180s"
}