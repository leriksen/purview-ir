resource azapi_data_plane_resource "managed_pe" {
  name      = var.name
  parent_id = var.mvnet_name
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

# resource time_sleep "sleep_240s" {
#   create_duration = "240s"
#   depends_on = [
#     azapi_data_plane_resource.this
#   ]
# }

resource azapi_update_resource "approve_pl" {
  name = local.pl_name
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