terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.5.0"
    }
  }
}
