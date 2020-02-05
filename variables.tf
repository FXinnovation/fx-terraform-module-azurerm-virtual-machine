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

variable "availability_set_managed" {
  description = "Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic)."
  default     = true
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

variable "network_interface_external_names" {
  description = "If defined, this network interfaces will be used by other virtual machines instead of creating a new network interfaces inside this module."
  default     = [""]
}

variable "network_interface_exists" {
  description = "If defined, will use var.network_interface_external_names to get network interfaces instead of creating a new network interfaces inside this module."
  default     = false
}

variable "network_interface_count" {
  description = "How many Network Interfaces to create per Virtual Machine."
  default     = 1
}

variable "network_interface_names" {
  description = "The name of the network interface. Changing this forces a new resource to be created."
  default     = ["net-interface"]
}

variable "network_interface_network_security_group_ids" {
  description = "The IDs of the Network Security Groups to associate with the network interfaces."
  default     = [""]
}

variable "network_interface_internal_dns_name_labels" {
  description = "Relative DNS names for this NIC used for internal communications between VMs in the same VNet."
  type        = list(string)
  default     = [""]
}

variable "network_interface_enable_ip_forwardings" {
  description = "Enables IP Forwarding on the NICs."
  type        = list(bool)
  default     = [false]
}

variable "network_interface_enable_accelerated_networkings" {
  description = "Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported."
  type        = list(bool)
  default     = [false]
}

variable "network_interface_dns_servers" {
  description = "List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list"
  type        = list(list(string))
  default     = [null]
}

variable "network_interface_ip_configuration_names" {
  description = "User-defined name of the IPs for the Network Interfaces."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_subnet_ids" {
  description = "Reference to subnets in which this NICs have been created. Required when private_ip_address_versions is IPv4."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_private_ip_addresses" {
  description = "Static IP Addresses."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_private_ip_address_allocations" {
  description = "Defines how a private IP addresses are assigned. Options are Static or Dynamic."
  type        = list(string)
  default     = ["Dynamic"]
}

variable "network_interface_ip_configuration_private_ip_address_versions" {
  description = "The IP versions to use. Possible values are IPv4 or IPv6."
  type        = list(string)
  default     = ["IPv4"]
}

variable "network_interface_ip_configuration_public_ip_address_ids" {
  description = "Reference to a Public IP Address to associate with this NIC."
  type        = list(string)
  default     = [""]
}

variable "network_interface_tags" {
  description = "Tags specific to the network interface."
  default     = {}
}

variable "network_interface_application_security_group_count" {
  description = "How many Network Interfaces security groups to associate per Network Interface."
  default     = 0
}

variable "network_interface_application_security_group_ids" {
  description = "The IDs of the Application Security Groups which each Network Interfaces which should be connected to. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "network_interface_application_gateway_backend_address_pool_count" {
  description = "How many Gateway Backend Address Pools to associate per Network Interface."
  default     = 0
}

variable "network_interface_application_gateway_backend_address_pool_ids" {
  description = "The IDs of the Application Gateway's Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "network_interface_backend_address_pool_count" {
  description = "How many Backend Address Pools to associate per Network Interface."
  default     = 0
}

variable "network_interface_backend_address_pool_ids" {
  description = "The IDs of the Load Balancer Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "network_interface_nat_rule_association_count" {
  description = "How many NAT Rules to associate per Network Interface."
  default     = 0
}

variable "network_interface_nat_rule_id_ids" {
  description = "The IDs of the Load Balancer NAT Rules which each Network Interfaces which should be connected to. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

###
# Virtual Machine
###

variable "additional_capabilities_ultra_ssd_enabled" {
  description = "Should Ultra SSD disk be enabled for this Virtual Machine?"
  default     = false
}

variable "additional_unattend_config_setting_name" {
  description = "Specifies the name of the setting to which the content applies. Possible values are: FirstLogonCommands and AutoLogon."
  default     = "FirstLogonCommands"
}

variable "additional_unattend_config_content" {
  description = "Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component."
  default     = ""
}

variable "boot_diagnostics_enabled" {
  description = "Should Boot Diagnostics be enabled for this Virtual Machine?"
  default     = false
}

variable "boot_diagnostics_storage_uri" {
  description = "The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
  default     = ""
}

variable "delete_os_disk_on_termination" {
  description = "Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed?"
  default     = false
}

variable "delete_data_disks_on_termination" {
  description = "Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed?"
  default     = false
}

variable "license_type" {
  description = "Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows_Client and Windows_Server."
  default     = "Windows_Server"
}

variable "name" {
  description = "Specifies the name of the Virtual Machine. Changing this forces a new resource to be created."
  default     = "vm"
}

variable "os_profile_admin_username" {
  description = "Specifies the name of the local administrator account."
  default     = "testadmin"
}

variable "os_profile_admin_password" {
  description = "The password associated with the local administrator account."
  default     = "Passw0rd_TO_BE_CHANGED!"
}

variable "os_profile_custom_data" {
  description = "Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script. On other systems, this will be copied as a file on disk. Internally, Terraform will base64 encode this value before sending it to the API. The maximum length of the binary array is 65535 bytes."
  default     = ""
}

variable "os_profile_linux_config_disable_password_authentication" {
  description = "Specifies whether password authentication should be disabled. If set to false, an admin_password must be specified."
  default     = true
}

variable "os_profile_linux_config_ssh_keys" {
  description = "One or more ssh_keys blocks. This field is required if disable_password_authentication is set to true."
  default     = []
  type        = list(object({ key_data = string }))
}


variable "os_profile_windows_config_provision_vm_agent" {
  description = "Should the Azure Virtual Machine Guest Agent be installed on this Virtual Machine?"
  default     = false
}

variable "os_profile_windows_config_enable_automatic_upgrades" {
  description = "Are automatic updates enabled on this Virtual Machine?"
  default     = false
}

variable "os_profile_windows_config_timezone" {
  description = "Specifies the time zone of the virtual machine"
  default     = "UTC"
}

variable "os_profile_secrets_source_vault_id" {
  description = "Specifies the ID of the Key Vault to use."
  default     = ""
}

variable "os_profile_secrets_vault_certificates" {
  description = "One or more vault_certificates blocks."
  default     = []
  type        = list(object({ certificate_url = string, certificate_store = string }))
}

variable "plan_name" {
  description = "Specifies the name of the image from the marketplace."
  default     = ""
}

variable "plan_publisher" {
  description = "Specifies the publisher of the image."
  default     = ""
}

variable "plan_product" {
  description = "Specifies the product of the image from the marketplace."
  default     = ""
}

variable "storage_image_reference_id" {
  description = "Specifies the ID of the Custom Image which the Virtual Machine should be created from. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_image_reference_publisher" {
  description = "Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "Canonical"
}

variable "storage_image_reference_offer" {
  description = "Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "UbuntuServer"
}

variable "storage_image_reference_sku" {
  description = "Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "18.04-LTS"
}

variable "storage_image_reference_version" {
  description = "Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "latest"
}

variable "storage_os_disk_create_option" {
  description = "Specifies how the OS Disk should be created. Possible values are Attach (managed disks only) and FromImage."
  default     = "FromImage"
}

variable "storage_os_disk_name" {
  description = "Specifies how the OS Disk should be created. Possible values are Attach (managed disks only) and FromImage."
  default     = "vm-disk"
}

variable "storage_os_disk_caching" {
  description = "Specifies the caching requirements for the OS Disk. Possible values include None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
}

variable "storage_os_disk_size_gb" {
  description = "Specifies the size of the OS Disk in gigabytes."
  default     = 30
}

variable "storage_os_managed_disk_id" {
  description = "SSpecifies the ID of an existing Managed Disk which should be attached as the OS Disk of this Virtual Machine. If this is set then the create_option must be set to Attach."
  default     = ""
}

variable "storage_os_managed_disk_type" {
  description = "Specifies the type of Managed Disk which should be created. Possible values are Standard_LRS, StandardSSD_LRS or Premium_LRS."
  default     = "Standard_LRS"
}

variable "storage_os_write_accelerator_enabled" {
  description = "Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs."
  default     = false
}

variable "storage_os_vhd_uri" {
  description = "Specifies the URI of the VHD file backing this Unmanaged OS Disk. Changing this forces a new resource to be created."
  default     = ""
}

variable "vm_count" {
  description = "How many Virtual Machines to create."
  default     = 1
}

variable "vm_type" {
  description = "The type of Virtual Machines to create. Can be either \"Linux\" or \"Windows\"."
  default     = "Linux"
}

variable "vm_size" {
  description = "Specifies the size of the Virtual Machines. https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json."
  default     = "Standard_B1ls"
}

variable "vm_tags" {
  description = "Tags specific to the Virtual Machines."
  default     = {}
}

variable "winrm_protocol" {
  description = "Specifies the protocol of listener. Possible values are HTTP or HTTPS."
  default     = "HTTPS"
}

variable "winrm_certificate_url" {
  description = "The ID of the Key Vault Secret which contains the encrypted Certificate which should be installed on the Virtual Machine. This certificate must also be specified in the vault_certificates block within the os_profile_secrets block."
  default     = ""
}

###
# Managed Disks
###

variable "managed_disk_count" {
  description = "How many additional managed disk to attach to EACH Virtual Machines."
  default     = 0
}

variable "managed_disk_names" {
  description = "Specifies the names of the Managed Disks. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["vm-manage-disk"]
}

variable "managed_disk_storage_account_types" {
  description = "The types of storage to use for the Managed Disks. Possible values inside the list are Standard_LRS, Premium_LRS, StandardSSD_LRS or UltraSSD_LRS."
  type        = list(string)
  default     = ["Standard_LRS"]
}

variable "managed_disk_size_gbs" {
  description = "Specifies the sizes of the Managed Disks to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size."
  type        = list(number)
  default     = [5]
}

variable "managed_disk_create_options" {
  description = "The methods to use when creating the Managed Disks. Possible values include: Empty, FromImage, Copy, Import, Restore."
  type        = list(string)
  default     = ["Empty"]
}

variable "managed_disk_cachings" {
  description = "Specifies the caching requirements for the Managed Disks. Possible values include None, ReadOnly and ReadWrite."
  type        = list(string)
  default     = ["ReadWrite"]
}

variable "managed_disk_write_accelerator_enableds" {
  description = "Specifies if Write Accelerator is enabled on Managed Disks. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs."
  type        = list(bool)
  default     = [false]
}

variable "managed_disk_image_reference_ids" {
  description = "IDs of an existing platform/marketplace disk image to copy when create_option is FromImage. CAREFUL: if you create multiple Managed Disks with different create_option, make sure this list matches with the disks having \"FromImage\" on (meaning this list may have empty values)."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_source_resource_ids" {
  description = "The IDs of existing Managed Disks to copy create_option is Copy or the recovery points to restore when create_option is Restore. CAREFUL: if you create multiple Managed Disks with different create_option, make sure this list matches with the disks having \"Copy\"/\"Restore\" on (meaning this list may have empty values)."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_source_uris" {
  description = "URI to a valid VHD file to be used when create_option is Import. CAREFUL: if you create multiple Managed Disks with different create_option, make sure this list matches with the disks having \"Import\" on (meaning this list may have empty values)."
  type        = list(string)
  default     = [""]
}

variable "managed_disk_os_types" {
  description = "Specify values when the source of an Import or Copy operation targets a source that contains an operating system. Valid values inside the list are Linux or Windows. CAREFUL: if you create multiple Managed Disks with different create_option, make sure this list matches with the disks having \"Copy\"/\"Import\"  on (meaning this list may have empty values)."
  type        = list(string)
  default     = ["Linux"]
}

variable "managed_disk_tags" {
  description = "Tags specific to the Managed Disks."
  default     = {}
}
