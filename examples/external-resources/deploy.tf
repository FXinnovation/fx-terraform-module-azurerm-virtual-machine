data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "West US"
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
  name = "tftest${random_string.this.result}"

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

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.service_principal_object_id

    key_permissions = [
      "create",
      "get",
      "list",
      "wrapkey",
      "unwrapkey",
      "get",
    ]

    secret_permissions = [
      "get",
      "set",
    ]
  }
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

  managed_disk_source_vault_id             = azurerm_key_vault.example.id
  managed_disk_key_encryption_key_key_urls = [azurerm_key_vault_key.example.id]

  name = "tftest${random_string.this.result}"

  os_profile_linux_config_ssh_keys = [{
    key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD3gEe3zm4Z5AZtAD1qhD6f5hyg6qMBQA8SuMAVtAP8q8k/kFu/oCU6DUMUBO83SQIXBnEniBs2EMl8xUMXShrmYqHZE6bZZeBVg2y8Kr2ReCCSMPH5TDbPTWrGJR7x0SIBXgsjctOazCyMBB98lMgcK++P0PQnqGSvRj7iZbiyN2KNaXE1ukZ4USGeTWxoh9NFVilIt5R0pI5CECSLajKgXJMUl3QWc5bHL8fSpvHqoRfItiPEmpm5pSQb519jkdT7ohnhSwIA8qBo6sAnfrRH0ydLT3swglyn44FDs4hCSSK1Hu4n1vYMBWgzGyfxWJlVV483MJYduxamMGIpyjgLCRcQ7sIwWnkSepKpj6okEN+0D9JM/64uk5p0oZ1bBQ3UU/D1XDxOHkyOobFiGUn2GSnKs3CdDhLbKobjK2RN6Qs/mqJ2Ux8eqQr4n76X/4xHuuqtJMc/OyfOKTRE7BZ7MhBP5r6btMks2GEATye34qiHwH7YNy1/no2ynW8RI8= test@tests"
  }]
}
