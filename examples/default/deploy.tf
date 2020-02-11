data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "Canada Central"
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

resource "azurerm_application_security_group" "example" {
  name                = "tftest${random_string.this.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
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
      "delete",
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

  num_suffix_digits = 4

  availability_set_name = "tftest${random_string.this.result}"
  availability_set_tags = {
    test = "tftest${random_string.this.result}"
  }

  network_interface_enabled                     = true
  network_interface_names                       = ["tftest${random_string.this.result}"]
  network_interface_internal_dns_name_labels    = ["tftest${random_string.this.result}"]
  network_interface_ip_configuration_names      = ["tftest${random_string.this.result}"]
  network_interface_ip_configuration_subnet_ids = [azurerm_subnet.example.id]
  network_interface_tags = {
    test = "tftest${random_string.this.result}"
  }

  network_interface_application_security_group_count = 1
  network_interface_application_security_group_ids = [
    {
      network_interface_index       = 0
      application_security_group_id = azurerm_application_security_group.example.id
    },
  ]

  managed_disk_count                   = 1
  managed_disk_names                   = ["tftest${random_string.this.result}"]
  managed_disk_source_vault_id         = azurerm_key_vault.example.id
  disk_encryption_set_name             = "tftest${random_string.this.result}"
  disk_encryption_set_key_vault_key_id = azurerm_key_vault_key.example.id

  name = "tftest${random_string.this.result}"

  os_profile_linux_config_ssh_keys = [{
    key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD3gEe3zm4Z5AZtAD1qhD6f5hyg6qMBQA8SuMAVtAP8q8k/kFu/oCU6DUMUBO83SQIXBnEniBs2EMl8xUMXShrmYqHZE6bZZeBVg2y8Kr2ReCCSMPH5TDbPTWrGJR7x0SIBXgsjctOazCyMBB98lMgcK++P0PQnqGSvRj7iZbiyN2KNaXE1ukZ4USGeTWxoh9NFVilIt5R0pI5CECSLajKgXJMUl3QWc5bHL8fSpvHqoRfItiPEmpm5pSQb519jkdT7ohnhSwIA8qBo6sAnfrRH0ydLT3swglyn44FDs4hCSSK1Hu4n1vYMBWgzGyfxWJlVV483MJYduxamMGIpyjgLCRcQ7sIwWnkSepKpj6okEN+0D9JM/64uk5p0oZ1bBQ3UU/D1XDxOHkyOobFiGUn2GSnKs3CdDhLbKobjK2RN6Qs/mqJ2Ux8eqQr4n76X/4xHuuqtJMc/OyfOKTRE7BZ7MhBP5r6btMks2GEATye34qiHwH7YNy1/no2ynW8RI8= test@tests"
  }]
}
