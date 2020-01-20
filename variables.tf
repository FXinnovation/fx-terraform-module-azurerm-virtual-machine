###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "azurerm_resource_group_location" {
  description = "pecifies the supported Azure location where the resources exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "azurerm_resource_group_name" {
  description = "The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created."
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource"
  default     = {}
}

###
# Availability set
###

variable "availability_set_enabled" {
  description = "Whether or not to create an availability set."
  default     = true
}

variable "availability_set_id" {
  description = "If defined, this variable will be used by other resources instead of creating a new availability set inside this module."
  default     = ""
}

variable "availability_set_name" {
  description = "Specifies the name of the availability set. Changing this forces a new resource to be created."
  default     = ""
}

variable "availability_set_tags" {
  description = "Tags specific to the availability set."
  default     = {}
}
