terraform {
  required_version = "~>1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }

    azapi = {
      source = "azure/azapi"
      version = "2.5.0"
    }
  }

  backend "local" {}
}