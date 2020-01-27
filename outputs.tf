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
  value = compact(concat(azurerm_network_interface.this.*.id, [""]))
}

output "network_interface_mac_addresses" {
  value = compact(concat(azurerm_network_interface.this.*.mac_address, [""]))
}

output "network_interface_private_ip_addresses" {
  value = compact(concat(azurerm_network_interface.this.*.private_ip_address, [""]))
}

output "network_interface_virtual_machine_ids" {
  value = compact(concat(azurerm_network_interface.this.*.virtual_machine_id, [""]))
}

###
# Virtual Machines
###

output "ids" {
  value = local.vm_ids
}

output "identities" {
  value = compact(concat(flatten(azurerm_virtual_machine.linux.*.identity), flatten(azurerm_virtual_machine.windows.*.identity), [""]))
}
