output "managed_pe" {
  value = azapi_data_plane_resource.managed_pe.output
}

output query {
  value = local.query
}

output resource_id {
  value = var.resource_id
}

output data_azapi_resource_pe {
  value = data.azapi_resource.pe.output.query
}