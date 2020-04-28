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
    Owner = "Terraform"
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

resource "azurerm_application_security_group" "example" {
  name                = "tftest${random_string.this.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

module "example" {
  source = "../.."

  resource_group_location = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  tags = {
    env = "test"
  }

  availability_set_enabled = true
  availability_set_name    = "tftest${random_string.this.result}"
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

  managed_disk_count = 1
  managed_disk_names = ["tftest${random_string.this.result}ext"]

  vm_names                         = ["tftest${random_string.this.result}"]
  vm_size                          = "Standard_B2ms"
  vm_type                          = "Linux"
  linux_vm_enabled                 = true
  admin_username                   = "testadmin"
  os_disk_caching                  = "ReadWrite"
  os_disk_size_gb                  = 30
  os_disk_storage_account_type     = "Standard_LRS"
  allow_extension_operations       = true
  source_image_reference_publisher = "Canonical"
  source_image_reference_offer     = "UbuntuServer"
  source_image_reference_sku       = "18.04-LTS"
  source_image_reference_version   = "latest"
  priority                         = "Regular"
  provision_vm_agent               = true

  linux_admin_ssh_keys = [{
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD3gEe3zm4Z5AZtAD1qhD6f5hyg6qMBQA8SuMAVtAP8q8k/kFu/oCU6DUMUBO83SQIXBnEniBs2EMl8xUMXShrmYqHZE6bZZeBVg2y8Kr2ReCCSMPH5TDbPTWrGJR7x0SIBXgsjctOazCyMBB98lMgcK++P0PQnqGSvRj7iZbiyN2KNaXE1ukZ4USGeTWxoh9NFVilIt5R0pI5CECSLajKgXJMUl3QWc5bHL8fSpvHqoRfItiPEmpm5pSQb519jkdT7ohnhSwIA8qBo6sAnfrRH0ydLT3swglyn44FDs4hCSSK1Hu4n1vYMBWgzGyfxWJlVV483MJYduxamMGIpyjgLCRcQ7sIwWnkSepKpj6okEN+0D9JM/64uk5p0oZ1bBQ3UU/D1XDxOHkyOobFiGUn2GSnKs3CdDhLbKobjK2RN6Qs/mqJ2Ux8eqQr4n76X/4xHuuqtJMc/OyfOKTRE7BZ7MhBP5r6btMks2GEATye34qiHwH7YNy1/no2ynW8RI8= test@tests"
    username   = "testadmin"
  }]
}
