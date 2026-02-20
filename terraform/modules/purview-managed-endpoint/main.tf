resource azapi_data_plane_resource "managed_pe" {
  name      = var.name
  parent_id = format("%s/managedvirtualnetworks/%s", var.purview_endpoint, var.mvnet_name)
  type      = "Microsoft.Purview/accounts/Scanning/managedvirtualnetworks/managedprivateendpoints@2022-02-01-preview"

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
  name = local.pe_name
  parent_id = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  type = format(
    "%s/%s@%s",
    local.resource_api[var.resource_kind].endpoint,
    "privateEndpointConnections",
    local.resource_api[var.resource_kind].version
  )
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