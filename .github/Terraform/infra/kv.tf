data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                          = local.keyvault_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  enabled_for_disk_encryption   = true
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  public_network_access_enabled = true

  sku_name = "standard"

  rbac_authorization_enabled = true


  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"

  }
}

resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}