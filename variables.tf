###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "resource_group_location" {
  description = "pecifies the supported Azure location where the resources exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created."
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource"
  default     = {}
}

variable "num_suffix_digits" {
  description = "How many digits to use for resources names."
  default     = 2
}

###
# Availability set
###

variable "availability_set_enabled" {
  description = "Whether or not to create an availability set."
  default     = true
}

variable "availability_set_exists" {
  description = "If defined, the existing availability set will be used by virtual machines instead of creating a new availability set inside this module."
  default     = false
}

variable "availability_set_name" {
  description = "Specifies the name of the availability set. Changing this forces a new resource to be created."
  default     = ""
}

variable "availability_set_tags" {
  description = "Tags specific to the availability set."
  default     = {}
}

###
# Network Interface
###

variable "network_interface_enabled" {
  description = "Whether or not to create a network interface."
  default     = true
}

variable "network_interface_names" {
  description = "If defined, this network interfaces will be used by other virtual machines instead of creating a new network interfaces inside this module."
  default     = [""]
}

variable "network_interface_name" {
  description = "The name of the network interface. Changing this forces a new resource to be created."
  default     = ""
}

variable "network_interface_network_security_group_id" {
  description = "The ID of the Network Security Group to associate with the network interface."
  default     = ""
}

variable "network_interface_internal_dns_name_label" {
  description = "Relative DNS name for this NIC used for internal communications between VMs in the same VNet."
  default     = ""
}

variable "network_interface_enable_ip_forwarding" {
  description = "Enables IP Forwarding on the NIC. "
  default     = false
}

variable "network_interface_enable_accelerated_networking" {
  description = "Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported."
  default     = false
}

variable "network_interface_dns_servers" {
  description = "List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list"
  default     = []
}

variable "network_interface_ip_configuration_name" {
  description = "User-defined name of the IP."
  default     = ""
}

variable "network_interface_ip_configuration_subnet_id" {
  description = "Reference to a subnet in which this NIC has been created. Required when private_ip_address_version is IPv4."
  default     = ""
}

variable "network_interface_ip_configuration_private_ip_address" {
  description = "Static IP Address."
  default     = ""
}

variable "network_interface_ip_configuration_private_ip_address_allocation" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic."
  default     = "Dynamic"
}

variable "network_interface_ip_configuration_private_ip_address_version" {
  description = "The IP Version to use. Possible values are IPv4 or IPv6."
  default     = "IPv4"
}

variable "network_interface_ip_configuration_public_ip_address_id" {
  description = "Reference to a Public IP Address to associate with this NIC."
  default     = ""
}

variable "network_interface_tags" {
  description = "Tags specific to the network interface."
  default     = {}
}

###
# Virtual Machine
###

variable "vm_count" {
  description = "How many virtual machines to create."
  default     = 1
}
