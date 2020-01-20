###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = var.enabled && var.availability_set_enabled && var.availability_set_name != "" ? 1 : 0

  name                = var.availability_set_name
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name

  tags = merge(
    {
      Terraform = "true"
    },
    var.tags,
    var.availability_set_tags,
  )
}
