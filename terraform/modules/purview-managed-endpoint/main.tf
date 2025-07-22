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

resource time_sleep "wait" {
  create_duration = "240s"
  depends_on = [
    azapi_data_plane_resource.managed_pe
  ]
}

resource azapi_update_resource "approve_pl" {
  for_each = local.pl_name

  depends_on = [
    time_sleep.wait
  ]

  name = each.value
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