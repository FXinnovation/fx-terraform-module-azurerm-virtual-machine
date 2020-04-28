###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resources exist. Changing this forces a new resource to be created."
  default     = "eastus"
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
  default     = 0
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

variable "availability_set_platform_update_domain_count" {
  description = "Specifies the number of update domains that are used."
  default     = 5
}

variable "availability_set_proximity_placement_group_id" {
  description = "The ID of the proximity placement group to which the virtual machine should be assigned. Changing this forces a new resource to be created."
  default     = ""
}

variable "availability_set_platform_fault_domain_count" {
  description = "Specifies the number of fault domains that are used."
  default     = 2
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
  description = "User-defined name of the IPs for the Network Interfaces. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_primary" {
  description = "Boolean flag which describes if ip configuration is primary one or not. Must be `true` for the first `ip_configuration` when multiple are specified. Defaults to `fasle`."
  type        = list(bool)
  default     = [true]
}

variable "network_interface_ip_configuration_subnet_ids" {
  description = "Reference to subnets in which this NICs have been created. Required when private_ip_address_versions is IPv4. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_private_ip_addresses" {
  description = "Static IP Addresses. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
  type        = list(string)
  default     = [""]
}

variable "network_interface_ip_configuration_private_ip_address_allocations" {
  description = "Defines how a private IP addresses are assigned. Options are Static or Dynamic. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
  type        = list(string)
  default     = ["Dynamic"]
}

variable "network_interface_ip_configuration_private_ip_address_versions" {
  description = "The IP versions to use. Possible values are IPv4 or IPv6. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
  type        = list(string)
  default     = ["IPv4"]
}

variable "network_interface_ip_configuration_public_ip_address_ids" {
  description = "Reference to a Public IP Address to associate with this NIC. Careful: this defines all the IP configurations meaning network_interface_count times vm_count."
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
  description = "The IDs of the Application Security Groups which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network_interface_index value is the index per Virtual Machine."
  type        = list(object({ network_interface_index = number, application_security_group_id = string }))
  default = [
    {
      network_interface_index       = 0
      application_security_group_id = ""
    }
  ]
}

variable "network_interface_application_gateway_backend_address_pool_count" {
  description = "How many Gateway Backend Address Pools to associate per Network Interface."
  default     = 0
}

variable "network_interface_application_gateway_backend_address_pool_ids" {
  description = "The IDs of the Application Gateway's Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network_interface_index value is the index per Virtual Machine."
  type        = list(object({ network_interface_index = number, application_gateway_backend_address_pool_id = string }))
  default = [
    {
      network_interface_index                     = 0
      application_gateway_backend_address_pool_id = ""
    }
  ]
}

variable "network_interface_backend_address_pool_count" {
  description = "How many Backend Address Pools to associate per Network Interface."
  default     = 0
}

variable "network_interface_backend_address_pool_ids" {
  description = "The IDs of the Load Balancer Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network_interface_index value is the index per Virtual Machine."
  type        = list(object({ network_interface_index = number, backend_address_pool_id = string }))
  default = [
    {
      network_interface_index = 0
      backend_address_pool_id = ""
    }
  ]
}

variable "network_interface_nat_rule_association_count" {
  description = "How many NAT Rules to associate per Network Interface."
  default     = 0
}

variable "network_interface_nat_rule_association_ids" {
  description = "The IDs of the Load Balancer NAT Rules which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network_interface_index value is the index per Virtual Machine."
  type        = list(object({ network_interface_index = number, nat_rule_id = string }))
  default = [
    {
      network_interface_index = 0
      nat_rule_id             = ""
    }
  ]
}

###
# Marketplace Agreement
###

variable "marketplace_agreement_publishers" {
  description = "Should Ultra SSD disk be enabled for this Virtual Machine?"
  default     = []
}

variable "marketplace_agreement_offers" {
  description = "Should Ultra SSD disk be enabled for this Virtual Machine?"
  default     = []
}

variable "marketplace_agreement_plans" {
  description = "Should Ultra SSD disk be enabled for this Virtual Machine?"
  default     = []
}

###
# Virtual Machine
###

variable "vm_count" {
  description = "How many Virtual Machines to create."
  default     = 1
}

variable "vm_names" {
  description = "Specifies the names of the Virtual Machine. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["vm"]
}

variable "vm_size" {
  description = "Specifies the size of the Virtual Machines. https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json."
  default     = "Standard_B2ms"
}

variable "zone_enabled" {
  description = "Boolean flag which describes whether or not enable the zone. Changing this will force a new resource to be created."
  default     = false
}

variable "zone" {
  description = "The zone in which the virtual machine should be created. Changing this forces a new resource to be created."
  type        = number
  default     = null
}

variable "admin_username" {
  description = "Specifies the name of the virtual machine local administrator account."
  default     = "testadmin"
}

variable "admin_password" {
  description = "The virtual machine password associated with the local administrator account."
  default     = "Passw0rd_TO_BE_CHANGED!"
}

variable "allow_extension_operations" {
  description = "Boolean flag whcih provides the information about should the extension operations be allowed on the virtual machine? Chaning this forces a new resource to be created."
  default     = true
}

variable "priority" {
  description = "Specfies the priority of the virtual machine. Posssible values are `regular` an `Spot`. Defaults to `Regular`. Changing this forces a new resourec to be created."
  default     = "Regular"
}

variable "custom_data" {
  description = "The Base64-Encoded custom data which should be used for the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

variable "computer_names" {
  description = "Specifies the hostname which should be used for the virtual machine.If unspecified this defaults to the value of `vm_names` filed. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [null]
}

variable "max_bid_price" {
  description = "The maximum price youre willing to pay for the vitual machine, in US Dollard; which must be greater tha the current spot price. If this bid price falls below the current spot price the virtual machine will be evicted using the `evction_policy`. Defaults to `-1`, which means that the virtual machine should not be evicted for the price reason."
  default     = "-1"
}

variable "eviction_policy" {
  description = "Specifies what should happen when the virtual machine is evicted for the price reason when using the spot instance. At this time only supported value is `Deallocate`. Changing this forces a new resource to be created."
  default     = "Deallocate"
}

variable "source_image_id" {
  description = "The ID of the image which the virtual machine should be created from. Changing this forces a new resource to be created."
  default     = null
}

variable "dedicated_host_enabled" {
  description = "Boolean flag which describes whether the Decicated host id enabled or not."
  default     = false
}

variable "dedicated_host_ids" {
  description = "The list IDs of a dedicated host where th emachien should be run on. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [null]
}

variable "provision_vm_agent" {
  description = "Boolean flag which descibes should the Azure VM agent to provisioned on the virtual machine or not. Defaults to `true`. Changing this forces a new resource to be created."
  default     = true
}

variable "proximity_placement_group_id" {
  description = "The ID of the proximity placement group which the virtual machine should be assigned to. Changing this forces a new resource to be created."
  default     = null
}

variable "additional_capabilities_ultra_ssd_enabled" {
  description = "Should Ultra SSD disk be enabled for this Virtual Machine?"
  default     = false
}

variable "boot_diagnostics_enabled" {
  description = "Boolean flag which describes whether or not enable the boot diagnostics setting for the virtual machine."
  default     = false
}

variable "boot_diagnostics_storage_account_uri" {
  description = "The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
  default     = ""
}

variable "source_image_reference_publisher" {
  description = "Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "MicrosoftWindowsServer"
}

variable "source_image_reference_offer" {
  description = "Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "WindowsServer"
}

variable "source_image_reference_sku" {
  description = "Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "2016-Datacenter"
}

variable "source_image_reference_version" {
  description = "Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created."
  default     = "latest"
}

variable "identity_types" {
  description = "The list of types of Managed identity which should be assigned to the virtual machine. Possible values are `systemassigned`, `UserAssigned` and `SustemAssigned,UserAssigned`."
  default     = [""]
}

variable "identity_identity_ids" {
  description = "A list of list of User managed identity ID's which should be assigned to the virtual machine."
  type        = list(list(string))
  default     = [null]
}

variable "os_disk_caching" {
  description = "Specifies the caching requirements for the OS Disk. Possible values include None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
}

variable "os_disk_size_gb" {
  description = "Specifies the size of the OS Disk in gigabytes."
  default     = 30
}

variable "os_disk_storage_account_type" {
  description = "The type of storage account which should back the internal OS disk. Possible values are `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`. Changing this forces a new resource to be created."
  default     = "Standard_LRS"
}

variable "os_disk_encryption_set_id" {
  description = "The ID of the Disk encryption set which should be used to encrypt the OS disk. `NOTE: The Disk encryption set must have the `READER` role assignmnet scoped on the key vault- in addition to an access policy to the key vault`."
  default     = null
}

variable "diff_disk_settings_option" {
  description = "Specifies the Ephemeral disk settings for the OS Disk. At this time the only possible value is `local`. Changing this forces a new resource to be created."
  default     = ""
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

variable "secret_key_vault_id" {
  description = "The ID of the key vault from which all secrets should be sourced."
  default     = ""
}

variable "certificate_url" {
  description = "The Secret URL of the Key vault certificate."
  default     = ""
}

variable "vm_tags" {
  description = "Tags specific to the Virtual Machines."
  default     = {}
}

###
# Windows virtual machine
###

variable "windows_vm_enabled" {
  description = "Whether or not create windows virtual machine."
  default     = false
}

variable "windows_timezone" {
  description = "Specifies the timezone which should be used by the virtual machine. The possible values are defined over here: https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/ "
  default     = "UTC"
}

variable "windows_license_type" {
  description = "Specifies the type of on-premise license (also know as `Azure Hybrid Use Benefits`) which should be used for the virtual machine. Possible values are `None`, `Windows_client` and `Windows_Server`. Changing this forces a new resource to be created."
  default     = ""
}

variable "windows_enable_automatic_updates" {
  description = "Specifies if the automatic updates are enabled for the windows virtual machine. Changing this forces a new resource to be created."
  default     = false
}

variable "additional_unattend_content_windows_setting" {
  description = "Specifies the name of the setting to which the content applies. Possible values are: `FirstLogonCommands` and `AutoLogon`."
  default     = "FirstLogonCommands"
}

variable "additional_unattend_content_windows_content" {
  description = "Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component."
  default     = ""
}

variable "windows_certificate_store" {
  description = "The certificate store on the windows virtual machine where the certificate should be added."
  default     = ""
}

variable "winrm_listener_protocol" {
  description = "Specifies the protocol of listener. Possible values are `Http` or `Https`."
  default     = "Http"
}

variable "winrm_listener_certificate_url" {
  description = "The ID of the Key Vault Secret which contains the encrypted Certificate which should be installed on the Virtual Machine. This certificate must also be specified in the vault_certificates block within the os_profile_secrets block."
  default     = ""
}

###
# Linux virtual machine
###

variable "linux_vm_enabled" {
  description = "Boolean flag which describes whether or not enable the linux virtual machine resource."
  default     = false
}

variable "linux_admin_ssh_keys" {
  description = "One or more admin ssh_key blocks. `NOTE`: One of either `admin_password` or `admin_ssh_key must be specified`."
  type        = list(object({ public_key = string, username = string }))
  default     = [null]
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
  default     = ["Windows"]
}

variable "managed_disk_encryption_settings_enabled" {
  description = "Boolean flag which describes whether the encryption is enabled on the managed disk or not. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "managed_disk_encryption_key_secret_url" {
  description = "Refeerence to the URL of the key vault secret used as the disk encryption key. This can be found as `id` on the `azurerm_key_vault_secret` resource."
  type        = string
  default     = ""
}

variable "managed_disk_encryption_key_source_vault_id" {
  description = "The URl of the key vault. This can be found as `Vault_uri` on the `azurerm_key_vault` resource."
  type        = string
  default     = ""
}

variable "managed_disk_key_encryption_key_key_url" {
  description = "The URL to the key vault key used as the key encryption key. This can be found as `id` on the `azurerm_key_vault_key` resource."
  type        = string
  default     = ""
}

variable "managed_disk_key_encryption_key_source_valut_id" {
  description = "The ID of the source key vault."
  type        = string
  default     = ""
}

variable "managed_data_disk_cachings" {
  description = "Specifies the caching requirements for the Managed Disks. Possible values include None, ReadOnly and ReadWrite."
  type        = list(string)
  default     = ["ReadWrite"]
}

variable "managed_data_disk_write_accelerator_enableds" {
  description = "Specifies if Write Accelerator is enabled on Managed Disks. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs."
  type        = list(bool)
  default     = [false]
}

variable "managed_data_disk_create_options" {
  description = "Specifies the list of create option of the data disk such as `Empty` or `Attach`. Defaults to `Attach`. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["Attach"]
}

variable "vm_type" {
  description = "The type of Virtual Machine. Can be either \"Linux\" or \"Windows\"."
  default     = "Windows"
}

variable "managed_disk_tags" {
  description = "Tags specific to the Managed Disks."
  default     = {}
}

###
# Virtual machine extensions
###

variable "vm_extensions_enabled" {
  description = "Booelan flag which describes whether or not to enable the virtual machine extensions."
  default     = false
}

variable "vm_extension_count" {
  description = "How many extensions have to be configured to EACH virtual machine."
  type        = number
  default     = 1
}

variable "vm_extension_names" {
  description = "The list of names of virtual machine extension peering. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_types" {
  description = "List which specifies the type of extension, available types for a publisher can be found using Azure CLI. `NOTE`: The `Publisher` and `Type` of virtual machine extension can be found using the Azure CLI, via: `shell $ az vm extension image list --location westus -o table`."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_settings" {
  description = "List of settings passed to the extension, these are specified as a JSON object in a string. Please `Note`: Certain VM Extensions require that the keys in the `settings` block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the `JsonADDomainExtension extension`, the keys are expected to be in `TitleCase`.)."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_publishers" {
  description = "The List of publisher of the extensions, available publisher can be found by using the Azure CLI `via: az vm extension image list --location westus -o table`."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_protected_settings" {
  description = "The list of protected settings passed to the extension, like settings, these are specified as a JSON object in a string."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_type_handler_versions" {
  description = "Specifies the list of version of the extensions to use, available versions can be found using Azure CLI."
  type        = list(string)
  default     = [""]
}

variable "vm_extension_auto_upgarde_minor_version" {
  description = "Boolean flag list which describes if the platform deploys the latest minor version update to the `type_handler_version` specified."
  default     = [false]
}

variable "vm_extension_tags" {
  description = "Tags which will be associated to the virtual machine extensions."
  default     = {}
}
