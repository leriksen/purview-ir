resource azapi_data_plane_resource "managed_pe" {
  name      = var.name
  parent_id = format("%s/managedvirtualnetworks/%s", var.purview_endpoint, var.mvnet_name)
  type      = "Microsoft.Purview/accounts/Scanning/managedvirtualnetworks/managedprivateendpoints@2023-09-01"

  body = {
    properties = {
      privateLinkResourceId = var.resource_id
      groupId               = var.subresource
    }
  }

  response_export_values = [
    "id",
    "name",
    "properties"
  ]
}

resource azapi_update_resource "approve_pl" {
  name = data.azapi_resource.pe.output.query
  parent_id = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  type = local.kind_api[var.resource_kind]
  body = {
    properties = {
      privateLinkServiceConnectionState = {
        status      = "Approved"
        description = "Auto-Approved"
      }
    }
  }

  response_export_values = ["*"]
}