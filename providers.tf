provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }

  }
}

# authenticate into the databricks workspace via the Azure CLI
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.datalake-databricks.id
  host                        = azurerm_databricks_workspace.datalake-databricks.workspace_url
}

