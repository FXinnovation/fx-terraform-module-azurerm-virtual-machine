data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "West Europe"
  tags = {
    managed_by = "Terraform"
    EndDate    = "2020-04-22"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "tftest${random_string.this.result}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "tftest${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_availability_set" "example" {
  name                = "tftest${random_string.this.result}"
  managed             = true
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_interface" "example" {
  name                = "tftest${random_string.this.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "tftest${random_string.this.result}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_key_vault" "example" {
  name                = "tftest${random_string.this.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  enabled_for_disk_encryption = true
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "delete",
      "list",
      "wrapkey",
      "unwrapkey",
      "get",
    ]

    secret_permissions = [
      "get",
      "delete",
      "set",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = "tftest${random_string.this.result}"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_key_vault_key" "example" {
  name         = "tftest${random_string.this.result}"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

module "example" {
  source = "../.."

  enabled                 = true
  resource_group_location = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  tags = {
    env = "test"
  }

  availability_set_name    = azurerm_availability_set.example.name
  availability_set_enabled = true
  availability_set_exists  = true

  network_interface_external_names = [azurerm_network_interface.example.name]
  network_interface_exists         = true

  managed_disk_count = 1
  managed_disk_names = ["tftest${random_string.this.result}ext"]

  vm_names                         = ["tftest${random_string.this.result}"]
  vm_size                          = "Standard_F2"
  windows_vm_enabled               = true
  admin_username                   = "testadmin"
  admin_password                   = "Passw0rd_TO_BE_CHANGED!"
  os_disk_caching                  = "ReadWrite"
  os_disk_size_gb                  = 127
  os_disk_storage_account_type     = "Standard_LRS"
  allow_extension_operations       = true
  source_image_reference_publisher = "MicrosoftWindowsServer"
  source_image_reference_offer     = "WindowsServer"
  source_image_reference_sku       = "2016-Datacenter"
  source_image_reference_version   = "latest"
  windows_timezone                 = "UTC"
  priority                         = "Regular"
  windows_license_type             = "None"
  provision_vm_agent               = true
  windows_enable_automatic_updates = true

  osdisk_encryption_keyvault_url         = "https://${azurerm_key_vault.example.name}.vault.azure.net"
  osdisk_encryption_keyvault_resource_id  = "${azurerm_key_vault.example.id}"
  osdisk_encryption_key_encryption_key_urls = ["${azurerm_key_vault_key.example.id}"]
}
