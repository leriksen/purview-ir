data azapi_resource "pe" {
  # type = local.kind_api[var.resource_kind]
  type = "Microsoft.Storage/storageAccounts@2025-01-01"
  resource_id = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  response_export_values = [
    "properties.privateEndpointConnections"
  ]
  depends_on = [
    azapi_data_plane_resource.managed_pe,
    # time_sleep.sleep_240s
  ]
}

output "pe" {
  value = data.azapi_resource.pe
}