###
# Availability set
###

output "availability_set_id" {
  value = concat(azurerm_availability_set.this.*.id, [""])[0]
}

###
# Network Interface
###

output "network_interface_id" {
  value = concat(azurerm_network_interface.this.*.id, [""])[0]
}

output "network_interface_mac_address" {
  value = concat(azurerm_network_interface.this.*.mac_address, [""])[0]
}

output "network_interface_private_ip_address" {
  value = concat(azurerm_network_interface.this.*.private_ip_address, [""])[0]
}

output "network_interface_virtual_machine_id" {
  value = concat(azurerm_network_interface.this.*.virtual_machine_id, [""])[0]
}

output "network_interface_applied_dns_servers" {
  value = concat(azurerm_network_interface.this.*.applied_dns_servers, [""])[0]
}
