resource "azurerm_storage_data_lake_gen2_filesystem" "adls" {
  name               = "adls"
  storage_account_id = var.adls_id
}

resource "azurerm_synapse_workspace" "synapse" {
  location                             = var.location
  name                                 = format("%s%s", "leriksenpurviewsynapse01", "uwou")
  resource_group_name                  = var.resource_group_name
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.adls.id
  sql_administrator_login              = "sqladminuser"
  identity {
    type = "SystemAssigned"
  }
}