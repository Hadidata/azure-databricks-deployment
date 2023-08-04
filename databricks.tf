resource "azurerm_databricks_workspace" "datalake-databricks" {
  name                = format("db-%s-%s", var.project, var.enviroment)
  resource_group_name = azurerm_resource_group.datalake-rg.name
  location            = azurerm_resource_group.datalake-rg.location
  sku                 = "premium"
}

# create an Azure keyvault backed scope in databricks

resource "databricks_secret_scope" "datalake-scope" {
  name = var.kv_scope_name

  keyvault_metadata {
    dns_name    = azurerm_key_vault.datalake-kv.vault_uri
    resource_id = azurerm_key_vault.datalake-kv.id
  }

}

resource "databricks_cluster" "datalake-cluster" {
  cluster_name            = "my_cluster"
  spark_version           = "12.2.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 25
  autoscale {
    min_workers = 1
    max_workers = 4
  }

  spark_conf = {
    format("fs.azure.account.auth.type.sa%s%s.dfs.core.windows.net", var.project, var.enviroment) : "OAuth",
    format("fs.azure.account.oauth.provider.type.sa%s%s.dfs.core.windows.net", var.project, var.enviroment) : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    format("fs.azure.account.oauth2.client.id.sa%s%s.dfs.core.windows.net", var.project, var.enviroment) : azuread_application.datalake-app.application_id,
    format("fs.azure.account.oauth2.client.secret.sa%s%s.dfs.core.windows.net", var.project, var.enviroment) : format("{{secrets/%s/key-app-%s-%s}}", var.kv_scope_name, var.project, var.enviroment)
    format("fs.azure.account.oauth2.client.endpoint.sa%s%s.dfs.core.windows.net", var.project, var.enviroment) : format("https://login.microsoftonline.com/%s/oauth2/token", data.azurerm_client_config.current.tenant_id)
  }

  depends_on = [databricks_secret_scope.datalake-scope, azurerm_key_vault_secret.datalake-secret]
}


