###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = var.enabled && var.availibility_set_name != "" ? 1 : 0

  name                = var.availibility_set_name
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name

  tags = merge(
    {
      Terraform = "true"
    },
    var.tags,
  )
}
