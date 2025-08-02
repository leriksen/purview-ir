output resource_group_name {
  value = "purview-jtrb"
}

output location {
  value = "australiaeast"
}

output scan_endpoint {
  value = "leriksen-purview-jtrb.purview.azure.com/scan"
}

output purview_id {
  value = "/subscriptions/743b758a-f6e7-4823-b706-950a64a6c9f9/resourceGroups/purview-jtrb/providers/Microsoft.Purview/accounts/leriksen-purview-jtrb"
}

output purview_managed_storage {
  value = "/subscriptions/743b758a-f6e7-4823-b706-950a64a6c9f9/resourceGroups/managed-rg-nyjbqxk/providers/Microsoft.Storage/storageAccounts/scanaustraliaeastkggongo"
}

output config {
  value = data.azurerm_client_config.current
}
