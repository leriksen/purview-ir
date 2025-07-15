data azapi_resource_list "this" {
  parent_id = var.purview_id
  type      = "Microsoft.Purview/accounts/Scanning/managedvirtualnetworks@2023-09-01"

  response_export_values = [ "*" ]
}