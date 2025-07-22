data azapi_resource "pe" {
  type                   = local.pe_api[var.resource_kind]
  resource_id            = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  response_export_values = {
    query = local.query
  }
}
