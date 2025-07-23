locals {
  resource_api = {
    sa       = {
      endpoint = "Microsoft.Storage/storageAccounts"
      version = "2024-01-01"
    }
    kv       = {
      endpoint = "Microsoft.KeyVault/vaults"
      version = "2024-11-01"
    }
    cosmosdb = {
      endpoint = "Microsoft.DocumentDb/databaseAccounts"
      version = "2025-04-15"
    }
    synapse  = {
      endpoint = "Microsoft.Synapse/workspaces"
      version = "2021-06-01"
    }
    purview  = {
      endpoint = "Microsoft.Purview/accounts"
      version = "2021-12-01"
    }
  }

  query = "properties.privateEndpointConnections[?properties.privateEndpoint.id=='${azapi_data_plane_resource.managed_pe.output.properties.resourceId}'].id | [0]"

  pe_name = element(split("/", data.azapi_resource.pe.output.query), -1)
}