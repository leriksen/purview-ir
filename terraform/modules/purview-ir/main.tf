resource azapi_data_plane_resource "this" {
  name      = var.ir_name
  parent_id = var.purview_id
  type      = "Microsoft.Purview/accounts/Scanning/integrationruntimes@2023-09-01"

  body = {
    kind       = var.kind
    properties = {
      description = var.mir_description
    }
  }

  response_export_values = [
    "id",
    "name",
    "properties"
  ]
}