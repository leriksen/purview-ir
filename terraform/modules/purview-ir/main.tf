resource azapi_data_plane_resource "mir" {
  name      = var.ir_name
  parent_id = var.purview_endpoint
  type      = "Microsoft.Purview/accounts/Scanning/integrationruntimes@2023-09-01"

  body = {
    kind       = var.kind
    properties = {
      description           = var.ir_description
      managedVirtualNetwork = {
        referenceName = var.mvnet_reference
        type          = "ManagedVirtualNetworkReference"
      }
    }
  }

  response_export_values = ["*"]
}

# after a Managed IR is created, it requires that the following private endpoints
# are added to the Managed Virtual Network
# - purview account
# - a storage account blob
# - a storage account queue
#
# these also need to have their private links approved
#
# create purview account private endpoint connection
module "account_pe" {
  source = "../purview-managed-endpoint"

  depends_on = [
    azapi_data_plane_resource.mir,
  ]
  purview_endpoint = var.purview_endpoint
  mvnet_name       = var.mvnet_reference
  name             = "purview-account"
  resource_id      = var.purview_id
  resource_kind    = "purview"
  subresource      = "account"
}

# create purview managed storage account blob private endpoint connection
module "storage_blob_pe" {
  source = "../purview-managed-endpoint"

  depends_on = [
    azapi_data_plane_resource.mir,
  ]
  purview_endpoint = var.purview_endpoint
  mvnet_name       = var.mvnet_reference
  name             = "purview-sa-blob"
  resource_id      = var.purview_managed_storage
  resource_kind    = "sa"
  subresource      = "blob"
}

# create purview managed storage account queue account private endpoint connection
module "storage_queue_pe" {
  source = "../purview-managed-endpoint"

  depends_on = [
    azapi_data_plane_resource.mir,
  ]
  purview_endpoint = var.purview_endpoint
  mvnet_name       = var.mvnet_reference
  name             = "purview-sa-queue"
  resource_id      = var.purview_managed_storage
  resource_kind    = "sa"
  subresource      = "queue"
}

