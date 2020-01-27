
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

  network_interface_enabled                    = true
  network_interface_name                       = "tftest${random_string.this.result}"
  network_interface_internal_dns_name_label    = "tftest${random_string.this.result}"
  network_interface_ip_configuration_name      = "tftest${random_string.this.result}"
  network_interface_ip_configuration_subnet_id = azurerm_subnet.example.id
  network_interface_tags = {
    test = "tftest${random_string.this.result}"
  }
}
