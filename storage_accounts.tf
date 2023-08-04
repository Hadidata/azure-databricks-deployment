resource "azurerm_storage_account" "datalake-storage-account" {
  name                     = format("sa%s%s", var.project, var.enviroment)
  resource_group_name      = azurerm_resource_group.datalake-rg.name
  location                 = azurerm_resource_group.datalake-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}

# containers within the storage container
resource "azurerm_storage_container" "datalake-storage-account-bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.datalake-storage-account.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.datalake-storage-account]
}

resource "azurerm_storage_container" "datalake-storage-account-silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.datalake-storage-account.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.datalake-storage-account]
}

resource "azurerm_storage_container" "datalake-storage-account-gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.datalake-storage-account.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.datalake-storage-account]
}