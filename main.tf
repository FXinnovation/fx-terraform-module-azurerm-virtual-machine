locals {
  should_create_availability_set  = var.enabled && var.availability_set_enabled && coalesce(var.availability_set_id)
  should_create_network_interface = var.enabled && var.network_interface_enabled && coalesce(concat(var.network_interface_ids, [""])[0])
}

###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = local.should_create_availability_set ? 1 : 0

  name                = var.availability_set_name
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name

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
  count = local.should_create_network_interface ? 1 : 0

  name                = var.network_interface_name
  location            = var.azurerm_resource_group_location
  resource_group_name = var.azurerm_resource_group_name

  network_security_group_id     = var.network_interface_network_security_group_id
  internal_dns_name_label       = var.network_interface_internal_dns_name_label
  enable_ip_forwarding          = var.network_interface_enable_ip_forwarding
  enable_accelerated_networking = var.network_interface_enable_accelerated_networking
  dns_servers                   = var.network_interface_dns_servers

  ip_configuration {
    name                          = var.network_interface_ip_configuration_name
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
