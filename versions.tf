terraform {
  required_version = ">= 1.5.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.85.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "=1.33.0"
    }

  }

}