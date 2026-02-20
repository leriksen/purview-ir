resource "azurerm_purview_account" "account" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource null_resource purview_root_collection_admin {
  triggers = {
    managed_identity      = azurerm_purview_account.account.identity[0].principal_id
    root_collection       = var.name
    root_collection_admin = var.root_collection_object_id
    script                = md5(file("${path.module}/scripts/purview_set_root_collection_admin.sh"))
  }

  provisioner local-exec {
    interpreter = ["bash", "-c"]
    working_dir = path.module

    environment = {
      RG            = var.resource_group_name
      PVIEW_ACCOUNT = var.name
      OBJECTID      = var.root_collection_object_id
    }

    command = "./scripts/purview_set_root_collection_admin.sh"
  }
}
