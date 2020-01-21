data "azurerm_network_interface" "this" {
  count = var.enabled ? var.vm_count : 0

  name                = concat(var.network_interface_names, [""])[0] == "" ? azurerm_network_interface.this.*.name[count.index] : var.network_interface_names[count.index]
  resource_group_name = var.resource_group_name
}

data "azurerm_availability_set" "this" {
  count = var.enabled && var.availability_set_enabled ? 1 : 0

  name                = var.availability_set_exists ? var.availability_set_name : concat(azurerm_availability_set.this.*.id, [""])[0]
  resource_group_name = var.resource_group_name
}
