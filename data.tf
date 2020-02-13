data "azurerm_network_interface" "this" {
  count = var.enabled && var.network_interface_exists ? var.vm_count : 0

  name                = var.network_interface_external_names[count.index]
  resource_group_name = var.resource_group_name
}

data "azurerm_availability_set" "this" {
  count = var.enabled && var.availability_set_enabled && var.availability_set_exists ? 1 : 0

  name                = var.availability_set_exists ? var.availability_set_name : concat(azurerm_availability_set.this.*.id, [""])[0]
  resource_group_name = var.resource_group_name
}

data "azurerm_platform_image" "this_os" {
  location  = var.resource_group_location
  publisher = var.storage_image_reference_publisher
  offer     = var.storage_image_reference_offer
  sku       = var.storage_image_reference_sku
}
