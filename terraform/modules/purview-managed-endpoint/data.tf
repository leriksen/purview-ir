data azapi_resource "pe" {
  type                   = format(
    "%s@%s",
    local.resource_api[var.resource_kind].endpoint,
    local.resource_api[var.resource_kind].version
  )
  resource_id            = azapi_data_plane_resource.managed_pe.output.properties.privateLinkResourceId
  response_export_values = {
    query = local.query
  }
}
