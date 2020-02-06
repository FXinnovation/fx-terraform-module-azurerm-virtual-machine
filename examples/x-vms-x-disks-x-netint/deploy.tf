
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

resource "azurerm_application_security_group" "example1" {
  name                = "tftest${random_string.this.result}1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_application_security_group" "example2" {
  name                = "tftest${random_string.this.result}2"
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

  availability_set_name = "tftest${random_string.this.result}"
  availability_set_tags = {
    test = "tftest${random_string.this.result}"
  }

  network_interface_enabled                     = true
  network_interface_count                       = 2
  network_interface_names                       = ["tftest${random_string.this.result}"]
  network_interface_internal_dns_name_labels    = ["tftest${random_string.this.result}-first", "tftest${random_string.this.result}-second"]
  network_interface_ip_configuration_names      = ["tftest${random_string.this.result}"]
  network_interface_ip_configuration_subnet_ids = [azurerm_subnet.example.id]
  network_interface_tags = {
    test = "tftest${random_string.this.result}"
  }

  network_interface_application_security_group_count = 2
  network_interface_application_security_group_ids   = [azurerm_application_security_group.example1.id, azurerm_application_security_group.example2.id]

  name     = "tftest${random_string.this.result}"
  vm_count = 2
  vm_size  = "Standard_B2s"
  vm_type  = "Windows"

  storage_image_reference_offer     = "WindowsServer"
  storage_image_reference_sku       = "2019-Datacenter"
  storage_image_reference_publisher = "MicrosoftWindowsServer"
  storage_os_disk_size_gb           = 127

  winrm_protocol = "HTTP"

  managed_disk_count                      = 3
  managed_disk_names                      = ["tftest1${random_string.this.result}", "tftest2${random_string.this.result}", "tftest3${random_string.this.result}"]
  managed_disk_storage_account_types      = ["Standard_LRS"]
  managed_disk_size_gbs                   = [5, 6, 10]
  managed_disk_create_options             = ["Empty", "Empty", "Empty"]
  managed_disk_cachings                   = ["ReadWrite"]
  managed_disk_write_accelerator_enableds = [false]
  managed_disk_os_types                   = ["Windows"]

  managed_disk_tags = {
    test = "tftest${random_string.this.result}"
  }
}
