
resource "azurerm_resource_group" "datalake-rg" {
  name     = format("rg-%s-%s", var.project, var.enviroment)
  location = var.region
}

data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Create an Azure key-vault 

resource "azurerm_key_vault" "datalake-kv" {
  name                        = format("kv-%s-%s", var.project, var.enviroment)
  location                    = azurerm_resource_group.datalake-rg.location
  resource_group_name         = azurerm_resource_group.datalake-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

}


resource "azurerm_key_vault_access_policy" "datalake-kv-policy" {
  key_vault_id = azurerm_key_vault.datalake-kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Set",
    "Recover",
    "Restore",
  "Purge"]

  depends_on = [azurerm_key_vault.datalake-kv]

}