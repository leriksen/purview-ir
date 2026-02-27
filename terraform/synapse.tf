resource "azurerm_storage_data_lake_gen2_filesystem" "adls" {
  name               = "adls"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_synapse_workspace" "synapse" {
  location                             = azurerm_resource_group.rg.location
  name                                 = format("%s%s", "leriksenpurviewsynapse01", random_string.suffix.result)
  resource_group_name                  = azurerm_resource_group.rg.name
  sql_administrator_login              = "sqladminuser"
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.adls.id
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_synapse_sql_pool" "dedicated" {
  name                 = format("%ssqlpool", azurerm_synapse_workspace.synapse.name)
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  storage_account_type = "GRS"
}
