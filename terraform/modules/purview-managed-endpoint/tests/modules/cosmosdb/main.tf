resource "azurerm_cosmosdb_account" "cosmos" {
  location            = var.location
  name                = format("%s%s", "leriksenpurviewcosmos01", "uwou")
  offer_type          = "Standard"
  resource_group_name = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
  geo_location {
    failover_priority = 0
    location          = "australiasoutheast"
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
}