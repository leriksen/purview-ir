locals {
  kind_api = {
    sa       = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-01-01"
    kv       = "Microsoft.KeyVault/vaults/privateEndpointConnections@2024-11-01"
    cosmosdb = "Microsoft.DocumentDb/databaseAccounts/privateEndpointConnections@2025-04-15"
    synapse  = "Microsoft.Synapse/workspaces/privateEndpointConnections@2021-06-01"
  }

  pl_name = data.azapi_resource.pe.output.properties.privateEndpointConnections[0].name
}