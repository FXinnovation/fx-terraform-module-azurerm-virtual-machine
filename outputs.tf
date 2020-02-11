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
  value = var.network_interface_count > 0 ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_network_interface.this.*.id, [""])), var.network_interface_count)) : {}
}

output "network_interface_private_ip_addresses" {
  value = var.network_interface_count > 0 ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_network_interface.this.*.private_ip_address, [""])), var.network_interface_count)) : {}
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
# Managed disks
###

output "azurerm_managed_disk_ids" {
  value = var.managed_disk_count > 0 ? zipmap(azurerm_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_managed_disk.this.*.id, [""])), var.managed_disk_count)) : {}
}
