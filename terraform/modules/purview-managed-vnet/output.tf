output "name" {
  depends_on = [
    time_sleep.mvnet_provisioning
  ]

  value = azapi_data_plane_resource.mvnet.output.name
}