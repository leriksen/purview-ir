output resource_group_name {
  value = "purview-uwou"
}

output location {
  value = "australiaeast"
}

output scan_endpoint {
  value = "leriksen-purview-uwou.purview.azure.com/scan"
}

output config {
  value = data.azurerm_client_config.current
}
