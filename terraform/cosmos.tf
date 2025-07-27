# resource "azurerm_cosmosdb_account" "cosmos" {
#   location            = azurerm_resource_group.rg.location
#   name = format("%s%s", "leriksenpurviewcosmos01", random_string.suffix.result)
#   offer_type          = "Standard"
#   resource_group_name = azurerm_resource_group.rg.name
#   identity {
#     type = "SystemAssigned"
#   }
#   geo_location {
#     failover_priority = 0
#     location          = "australiasoutheast"
#   }
#   consistency_policy {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }
# }