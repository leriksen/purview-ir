output "result" {
  value = azapi_data_plane_resource.mir.output
}

output "account_managed_pe" {
  value = module.account_pe.managed_pe
}

output "storage_blob_managed_pe" {
  value = module.storage_blob_pe.managed_pe
}

output "storage_queue_managed_pe" {
  value = module.storage_queue_pe.managed_pe
}
