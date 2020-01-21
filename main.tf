locals {
  should_create_availability_set  = var.enabled && var.availability_set_enabled
  should_create_network_interface = var.enabled && var.network_interface_enabled && var.vm_count > 0
}

###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = local.should_create_availability_set ? 1 : 0

  name                = var.availability_set_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = merge(
    var.tags,
    var.availability_set_tags,
    {
      Terraform = "true"
    },
  )
}

###
# Network Interface
###

resource "azurerm_network_interface" "this" {
  count = local.should_create_network_interface ? var.vm_count : 0

  name                = var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.network_interface_name, count.index + 1) : var.network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  network_security_group_id     = var.network_interface_network_security_group_id
  internal_dns_name_label       = var.network_interface_internal_dns_name_label
  enable_ip_forwarding          = var.network_interface_enable_ip_forwarding
  enable_accelerated_networking = var.network_interface_enable_accelerated_networking
  dns_servers                   = var.network_interface_dns_servers

  ip_configuration {
    name                          = var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.network_interface_ip_configuration_name, count.index + 1) : var.network_interface_ip_configuration_name
    subnet_id                     = var.network_interface_ip_configuration_subnet_id
    private_ip_address            = var.network_interface_ip_configuration_private_ip_address
    private_ip_address_allocation = var.network_interface_ip_configuration_private_ip_address_allocation
    private_ip_address_version    = var.network_interface_ip_configuration_private_ip_address_version
  }

  tags = merge(
    var.tags,
    var.network_interface_tags,
    {
      Terraform = "true"
    },
  )
}
