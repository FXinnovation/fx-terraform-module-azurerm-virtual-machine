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
  value = var.linux_vm_enabled != true && var.network_interface_count > 0 && compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id, [""])) != [] ? zipmap(azurerm_windows_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id, [""])), var.network_interface_count)) : zipmap(azurerm_linux_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id, [""])), var.network_interface_count))
}

output "network_interface_private_ip_addresses" {
  value = var.linux_vm_enabled != true && var.network_interface_count > 0 && compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.private_ip_address : azurerm_network_interface.this.*.private_ip_address, [""])) != [] ? zipmap(azurerm_windows_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.private_ip_address : azurerm_network_interface.this.*.private_ip_address, [""])), var.network_interface_count)) : zipmap(azurerm_linux_virtual_machine.this.*.id, chunklist(compact(concat(var.network_interface_exists ? data.azurerm_network_interface.this.*.private_ip_address : azurerm_network_interface.this.*.private_ip_address, [""])), var.network_interface_count))
}

###
# Virtual Machines
###

output "ids" {
  value = var.linux_vm_enabled != true ? azurerm_windows_virtual_machine.this.*.id : azurerm_linux_virtual_machine.this.*.id
}

output "identities" {
  value = var.linux_vm_enabled != true ? azurerm_windows_virtual_machine.this.*.identity : azurerm_linux_virtual_machine.this.*.identity
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
  value = var.linux_vm_enabled != true && var.managed_disk_count > 0 && compact(concat(azurerm_managed_disk.this.*.id, [""])) != [] ? zipmap(azurerm_windows_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_managed_disk.this.*.id, [""])), var.managed_disk_count)) : zipmap(azurerm_linux_virtual_machine.this.*.id, chunklist(compact(concat(azurerm_managed_disk.this.*.id, [""])), var.managed_disk_count))
}
