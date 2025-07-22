locals {
  kind_api = {
    sa       = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-01-01"
    kv       = "Microsoft.KeyVault/vaults/privateEndpointConnections@2024-11-01"
    cosmosdb = "Microsoft.DocumentDb/databaseAccounts/privateEndpointConnections@2025-04-15"
    synapse  = "Microsoft.Synapse/workspaces/privateEndpointConnections@2021-06-01"
    purview  = "Microsoft.Purview/accounts/privateEndpointConnections@2021-12-01"
  }

  pe_api = {
    sa       = "Microsoft.Storage/storageAccounts@2024-01-01"
    kv       = "Microsoft.KeyVault/vaults@2024-11-01"
    cosmosdb = "Microsoft.DocumentDb/databaseAccounts@2024-04-15"
    synapse  = "Microsoft.Synapse/workspaces@2021-06-01"
    purview  = "Microsoft.Purview/accounts@2021-12-01"
  }

  query = "properties.privateEndpointConnections[?properties.privateEndpoint.id=='${azapi_data_plane_resource.managed_pe.output.properties.resourceId}'].name | [0]"
}