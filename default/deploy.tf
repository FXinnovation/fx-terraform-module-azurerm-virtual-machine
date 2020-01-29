
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

module "example" {
  source = ".."

  resource_group_location = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  tags = {
    env = "test"
  }

  availability_set_name = "tftest${random_string.this.result}"
  availability_set_tags = {
    test = "tftest${random_string.this.result}"
  }

  network_interface_enabled                    = true
  network_interface_name                       = "tftest${random_string.this.result}"
  network_interface_internal_dns_name_label    = "tftest${random_string.this.result}"
  network_interface_ip_configuration_name      = "tftest${random_string.this.result}"
  network_interface_ip_configuration_subnet_id = azurerm_subnet.example.id
  network_interface_tags = {
    test = "tftest${random_string.this.result}"
  }

  name = "tftest${random_string.this.result}"

  os_profile_linux_config_ssh_keys = [{
    key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD3gEe3zm4Z5AZtAD1qhD6f5hyg6qMBQA8SuMAVtAP8q8k/kFu/oCU6DUMUBO83SQIXBnEniBs2EMl8xUMXShrmYqHZE6bZZeBVg2y8Kr2ReCCSMPH5TDbPTWrGJR7x0SIBXgsjctOazCyMBB98lMgcK++P0PQnqGSvRj7iZbiyN2KNaXE1ukZ4USGeTWxoh9NFVilIt5R0pI5CECSLajKgXJMUl3QWc5bHL8fSpvHqoRfItiPEmpm5pSQb519jkdT7ohnhSwIA8qBo6sAnfrRH0ydLT3swglyn44FDs4hCSSK1Hu4n1vYMBWgzGyfxWJlVV483MJYduxamMGIpyjgLCRcQ7sIwWnkSepKpj6okEN+0D9JM/64uk5p0oZ1bBQ3UU/D1XDxOHkyOobFiGUn2GSnKs3CdDhLbKobjK2RN6Qs/mqJ2Ux8eqQr4n76X/4xHuuqtJMc/OyfOKTRE7BZ7MhBP5r6btMks2GEATye34qiHwH7YNy1/no2ynW8RI8= test@tests"
  }]
}
