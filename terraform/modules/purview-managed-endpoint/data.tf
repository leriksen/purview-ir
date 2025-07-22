data azapi_resource "pe" {
  depends_on = [
    azapi_data_plane_resource.managed_pe,
  ]

  type = local.pe_api[var.resource_kind]
  resource_id = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  response_export_values = [ "*" ]
}

output data_azapi_resource_pe {
  value = data.azapi_resource.pe.output
}