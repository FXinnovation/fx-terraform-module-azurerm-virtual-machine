###
# Availability set
###

output "availability_set_id" {
  value = concat(azurerm_availability_set.this.*.id, [""])[0]
}

###
# Network Interface
###

output "network_interface_ids" {
  value = var.network_interface_count > 0 && compact(concat(azurerm_network_interface.this.*.id, [""])) != [] ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id, [""])), var.network_interface_count)) : {}
}

output "network_interface_mac_addresses" {
  value = var.network_interface_count > 0 && compact(concat(azurerm_network_interface.this.*.mac_address, [""])) != [] ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.mac_address, [""])), var.network_interface_count)) : {}
}

output "network_interface_private_ip_addresses" {
  value = var.network_interface_count > 0 && compact(concat(azurerm_network_interface.this.*.private_ip_address, [""])) != [] ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.private_ip_address, [""])), var.network_interface_count)) : {}
}

###
# Virtual Machines
###

output "ids" {
  value = azurerm_virtual_machine.this.*.id
}

output "identities" {
  value = azurerm_virtual_machine.this.*.identity
}

###
# Marketplace Agreement
###

output "marketplace_agreement_ids" {
  value = azurerm_marketplace_agreement.this.*.id
}

###
# Managed Disks
###

output "managed_disk_ids" {
  value = var.managed_disk_count > 0 && compact(concat(azurerm_managed_disk.this.*.id, [""])) != [] ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_managed_disk.this.*.id, [""])), var.managed_disk_count)) : {}
}
