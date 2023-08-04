## create an app registration so we can work with the storage accounts

resource "azuread_application" "datalake-app" {
  display_name     = format("app-%s-%s", var.project, var.enviroment)
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"
}

resource "azuread_service_principal" "datalake-principal" {
  application_id               = azuread_application.datalake-app.application_id
  app_role_assignment_required = false
}

resource "azuread_application_password" "datalake-secret" {
  display_name          = azuread_application.datalake-app.display_name
  application_object_id = azuread_application.datalake-app.object_id
}

resource "azurerm_role_assignment" "datalake-role" {
  scope                = azurerm_storage_account.datalake-storage-account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.datalake-principal.object_id
}


resource "azurerm_key_vault_secret" "datalake-secret" {
  name         = format("key-app-%s-%s", var.project, var.enviroment)
  value        = azuread_application_password.datalake-secret.value
  key_vault_id = azurerm_key_vault.datalake-kv.id

  depends_on = [azurerm_key_vault_access_policy.datalake-kv-policy]
}
