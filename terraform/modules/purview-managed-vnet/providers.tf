terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "2.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}

provider "azapi" {}
