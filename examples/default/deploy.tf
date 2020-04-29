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
}
