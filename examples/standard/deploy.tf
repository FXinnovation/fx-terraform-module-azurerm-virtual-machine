
resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "West US"
}

module "example" {
  source = "../.."

  azurerm_resource_group_location = azurerm_resource_group.example.location
  azurerm_resource_group_name     = azurerm_resource_group.example.name
  tags = {
    env = test
  }

  availability_set_name = "tftest${random_string.this.result}"
  availability_set_tags = {
    test = "tftest${random_string.this.result}"
  }
}
