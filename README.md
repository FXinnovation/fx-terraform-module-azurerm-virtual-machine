# terraform-module-azurerm-virtual-machine

## Usage
See `examples` folders for usage of this module.

## Limitation

- Any call of this module will create resources in a single resource group.
- Any network interfaces created in this module will have a single ip_configuration.
- Tags for VMs are shared among all VMs. Same thing for managed disks.
- OS storage disk cannot be encrypted for now (see: https://stackoverflow.com/questions/58920271/azure-terraform-encrypt-vm-os-disk).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | ~>1.42.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_capabilities\_ultra\_ssd\_enabled | Should Ultra SSD disk be enabled for this Virtual Machine? | `bool` | `false` | no |
| additional\_unattend\_config\_content | Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component. | `string` | `""` | no |
| additional\_unattend\_config\_setting\_name | Specifies the name of the setting to which the content applies. Possible values are: FirstLogonCommands and AutoLogon. | `string` | `"FirstLogonCommands"` | no |
| availability\_set\_enabled | Whether or not to create an availability set. | `bool` | `true` | no |
| availability\_set\_exists | If defined, the existing availability set will be used by virtual machines instead of creating a new availability set inside this module. | `bool` | `false` | no |
| availability\_set\_managed | Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic). | `bool` | `true` | no |
| availability\_set\_name | Specifies the name of the availability set. Changing this forces a new resource to be created. | `string` | `""` | no |
| availability\_set\_platform\_fault\_domain\_count | Specifies the number of fault domains that are used. | `number` | `2` | no |
| availability\_set\_platform\_update\_domain\_count | Specifies the number of update domains that are used. | `number` | `5` | no |
| availability\_set\_tags | Tags specific to the availability set. | `map` | `{}` | no |
| boot\_diagnostics\_enabled | Should Boot Diagnostics be enabled for this Virtual Machine? | `bool` | `false` | no |
| boot\_diagnostics\_storage\_uri | The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files. | `string` | `""` | no |
| delete\_data\_disks\_on\_termination | Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? | `bool` | `false` | no |
| delete\_os\_disk\_on\_termination | Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? | `bool` | `false` | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| license\_type | Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows\_Client and Windows\_Server. | `string` | `"Windows_Server"` | no |
| machine\_extension\_name | The name of the virtual machine extension peering. Changing this forces a new resource to be created. | `string` | `"machine-ext"` | no |
| managed\_disk\_cachings | Specifies the caching requirements for the Managed Disks. Possible values include None, ReadOnly and ReadWrite. | `list(string)` | <pre>[<br>  "ReadWrite"<br>]</pre> | no |
| managed\_disk\_count | How many additional managed disk to attach to EACH Virtual Machines. | `number` | `0` | no |
| managed\_disk\_create\_options | The methods to use when creating the Managed Disks. Possible values include: Empty, FromImage, Copy, Import, Restore. | `list(string)` | <pre>[<br>  "Empty"<br>]</pre> | no |
| managed\_disk\_encryption\_settings\_enabled | The URLs to the Key Vault Secrets used as the Disk Encryption Keys. This can be found as id on the azurerm\_key\_vault\_secret resource. | `bool` | `true` | no |
| managed\_disk\_image\_reference\_ids | IDs of an existing platform/marketplace disk image to copy when create\_option is FromImage. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "FromImage" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_key\_encryption\_key\_urls | The URLs to the Key Vault Keys used as the Key Encryption Keys. This can be found as id on the azurerm\_key\_vault\_key resource. | `list(string)` | `[]` | no |
| managed\_disk\_names | Specifies the names of the Managed Disks. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "vm-manage-disk"<br>]</pre> | no |
| managed\_disk\_os\_types | Specify values when the source of an Import or Copy operation targets a source that contains an operating system. Valid values inside the list are Linux or Windows. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Import"  on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  "Linux"<br>]</pre> | no |
| managed\_disk\_size\_gbs | Specifies the sizes of the Managed Disks to create in gigabytes. If create\_option is Copy or FromImage, then the value must be equal to or greater than the source's size. | `list(number)` | <pre>[<br>  5<br>]</pre> | no |
| managed\_disk\_source\_resource\_ids | The IDs of existing Managed Disks to copy create\_option is Copy or the recovery points to restore when create\_option is Restore. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Restore" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_source\_uris | URI to a valid VHD file to be used when create\_option is Import. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Import" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_source\_vault\_id | The ID of the Key Vault. This can be found as id on the azurerm\_key\_vault resource. | `string` | `""` | no |
| managed\_disk\_source\_vault\_uri | The URL of the Key Vault. This can be found as vault\_uri on the azurerm\_key\_vault resource. | `string` | `""` | no |
| managed\_disk\_storage\_account\_types | The types of storage to use for the Managed Disks. Possible values inside the list are Standard\_LRS, Premium\_LRS, StandardSSD\_LRS or UltraSSD\_LRS. | `list(string)` | <pre>[<br>  "Standard_LRS"<br>]</pre> | no |
| managed\_disk\_tags | Tags specific to the Managed Disks. | `map` | `{}` | no |
| managed\_disk\_write\_accelerator\_enableds | Specifies if Write Accelerator is enabled on Managed Disks. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| marketplace\_agreement\_offers | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| marketplace\_agreement\_plans | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| marketplace\_agreement\_publishers | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| name | Specifies the name of the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"vm"` | no |
| network\_interface\_application\_gateway\_backend\_address\_pool\_count | How many Gateway Backend Address Pools to associate per Network Interface. | `number` | `0` | no |
| network\_interface\_application\_gateway\_backend\_address\_pool\_ids | The IDs of the Application Gateway's Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network\_interface\_index value is the index per Virtual Machine. | `list(object({ network_interface_index = number, application_gateway_backend_address_pool_id = string }))` | <pre>[<br>  {<br>    "application_gateway_backend_address_pool_id": "",<br>    "network_interface_index": 0<br>  }<br>]</pre> | no |
| network\_interface\_application\_security\_group\_count | How many Network Interfaces security groups to associate per Network Interface. | `number` | `0` | no |
| network\_interface\_application\_security\_group\_ids | The IDs of the Application Security Groups which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network\_interface\_index value is the index per Virtual Machine. | `list(object({ network_interface_index = number, application_security_group_id = string }))` | <pre>[<br>  {<br>    "application_security_group_id": "",<br>    "network_interface_index": 0<br>  }<br>]</pre> | no |
| network\_interface\_backend\_address\_pool\_count | How many Backend Address Pools to associate per Network Interface. | `number` | `0` | no |
| network\_interface\_backend\_address\_pool\_ids | The IDs of the Load Balancer Backend Address Pools which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network\_interface\_index value is the index per Virtual Machine. | `list(object({ network_interface_index = number, backend_address_pool_id = string }))` | <pre>[<br>  {<br>    "backend_address_pool_id": "",<br>    "network_interface_index": 0<br>  }<br>]</pre> | no |
| network\_interface\_count | How many Network Interfaces to create per Virtual Machine. | `number` | `1` | no |
| network\_interface\_dns\_servers | List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| network\_interface\_enable\_accelerated\_networkings | Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| network\_interface\_enable\_ip\_forwardings | Enables IP Forwarding on the NICs. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| network\_interface\_enabled | Whether or not to create a network interface. | `bool` | `true` | no |
| network\_interface\_exists | If defined, will use var.network\_interface\_external\_names to get network interfaces instead of creating a new network interfaces inside this module. | `bool` | `false` | no |
| network\_interface\_external\_names | If defined, this network interfaces will be used by other virtual machines instead of creating a new network interfaces inside this module. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_internal\_dns\_name\_labels | Relative DNS names for this NIC used for internal communications between VMs in the same VNet. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_ip\_configuration\_names | User-defined name of the IPs for the Network Interfaces. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_allocations | Defines how a private IP addresses are assigned. Options are Static or Dynamic. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  "Dynamic"<br>]</pre> | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_versions | The IP versions to use. Possible values are IPv4 or IPv6. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  "IPv4"<br>]</pre> | no |
| network\_interface\_ip\_configuration\_private\_ip\_addresses | Static IP Addresses. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_ip\_configuration\_public\_ip\_address\_ids | Reference to a Public IP Address to associate with this NIC. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_ip\_configuration\_subnet\_ids | Reference to subnets in which this NICs have been created. Required when private\_ip\_address\_versions is IPv4. Careful: this defines all the IP configurations meaning network\_interface\_count times vm\_count. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_names | The name of the network interface. Changing this forces a new resource to be created. | `list` | <pre>[<br>  "net-interface"<br>]</pre> | no |
| network\_interface\_nat\_rule\_association\_count | How many NAT Rules to associate per Network Interface. | `number` | `0` | no |
| network\_interface\_nat\_rule\_association\_ids | The IDs of the Load Balancer NAT Rules which each Network Interfaces which should be connected to. Changing this forces a new resource to be created. Beware: network\_interface\_index value is the index per Virtual Machine. | `list(object({ network_interface_index = number, nat_rule_id = string }))` | <pre>[<br>  {<br>    "nat_rule_id": "",<br>    "network_interface_index": 0<br>  }<br>]</pre> | no |
| network\_interface\_network\_security\_group\_ids | The IDs of the Network Security Groups to associate with the network interfaces. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| network\_interface\_tags | Tags specific to the network interface. | `map` | `{}` | no |
| num\_suffix\_digits | How many digits to use for resources names. | `number` | `2` | no |
| os\_profile\_admin\_password | The password associated with the local administrator account. | `string` | `"Passw0rd_TO_BE_CHANGED!"` | no |
| os\_profile\_admin\_username | Specifies the name of the local administrator account. | `string` | `"testadmin"` | no |
| os\_profile\_custom\_data | Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script. On other systems, this will be copied as a file on disk. Internally, Terraform will base64 encode this value before sending it to the API. The maximum length of the binary array is 65535 bytes. | `string` | `""` | no |
| os\_profile\_linux\_config\_disable\_password\_authentication | Specifies whether password authentication should be disabled. If set to false, an admin\_password must be specified. | `bool` | `true` | no |
| os\_profile\_linux\_config\_ssh\_keys | One or more ssh\_keys blocks. This field is required if disable\_password\_authentication is set to true. | `list(object({ key_data = string }))` | `[]` | no |
| os\_profile\_secrets\_source\_vault\_id | Specifies the ID of the Key Vault to use. | `string` | `""` | no |
| os\_profile\_secrets\_vault\_certificates | One or more vault\_certificates blocks. | `list(object({ certificate_url = string, certificate_store = string }))` | `[]` | no |
| os\_profile\_windows\_config\_enable\_automatic\_upgrades | Are automatic updates enabled on this Virtual Machine? | `bool` | `false` | no |
| os\_profile\_windows\_config\_provision\_vm\_agent | Should the Azure Virtual Machine Guest Agent be installed on this Virtual Machine? | `bool` | `false` | no |
| os\_profile\_windows\_config\_timezone | Specifies the time zone of the virtual machine | `string` | `"UTC"` | no |
| plan\_name | Specifies the name of the image from the marketplace. | `string` | `""` | no |
| plan\_product | Specifies the product of the image from the marketplace. | `string` | `""` | no |
| plan\_publisher | Specifies the publisher of the image. | `string` | `""` | no |
| resource\_group\_location | Specifies the supported Azure location where the resources exist. Changing this forces a new resource to be created. | `string` | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created. | `string` | `""` | no |
| storage\_image\_reference\_id | Specifies the ID of the Custom Image which the Virtual Machine should be created from. Changing this forces a new resource to be created. | `string` | `""` | no |
| storage\_image\_reference\_offer | Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"UbuntuServer"` | no |
| storage\_image\_reference\_publisher | Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"Canonical"` | no |
| storage\_image\_reference\_sku | Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"18.04-LTS"` | no |
| storage\_image\_reference\_version | Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"latest"` | no |
| storage\_os\_disk\_caching | Specifies the caching requirements for the OS Disk. Possible values include None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| storage\_os\_disk\_create\_option | Specifies how the OS Disk should be created. Possible values are Attach (managed disks only) and FromImage. | `string` | `"FromImage"` | no |
| storage\_os\_disk\_managed\_disk\_create\_option | The method to use when creating the managed disk. Changing this forces a new resource to be created. For the OS disk. Possible values include: Empty, FromImage, Copy, Import, Restore. | `string` | `"FromImage"` | no |
| storage\_os\_disk\_managed\_disk\_source\_resource\_id | Copy an existing managed disk or snapshot. For the OS disk. Only when storage\_os\_disk\_managed\_disk\_create\_option = Copy. | `string` | `""` | no |
| storage\_os\_disk\_managed\_disk\_source\_uri | Import a VHD file in to the managed disk. For the OS disk. Only when storage\_os\_disk\_managed\_disk\_create\_option = Import. | `string` | `""` | no |
| storage\_os\_disk\_name | Specifies the name of the OS Disk. If empty, the name of the VMs will be used as names for the disks. | `string` | `""` | no |
| storage\_os\_disk\_size\_gb | Specifies the size of the OS Disk in gigabytes. | `number` | `30` | no |
| storage\_os\_managed\_disk\_type | Specifies the type of Managed Disk which should be created. Possible values are Standard\_LRS, StandardSSD\_LRS or Premium\_LRS. | `string` | `"Standard_LRS"` | no |
| storage\_os\_write\_accelerator\_enabled | Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. | `bool` | `false` | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | `map` | `{}` | no |
| vm\_count | How many Virtual Machines to create. | `number` | `1` | no |
| vm\_size | Specifies the size of the Virtual Machines. https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json. | `string` | `"Standard_B2ms"` | no |
| vm\_tags | Tags specific to the Virtual Machines. | `map` | `{}` | no |
| vm\_type | The type of Virtual Machines to create. Can be either "Linux" or "Windows". | `string` | `"Linux"` | no |
| winrm\_certificate\_url | The ID of the Key Vault Secret which contains the encrypted Certificate which should be installed on the Virtual Machine. This certificate must also be specified in the vault\_certificates block within the os\_profile\_secrets block. | `string` | `""` | no |
| winrm\_protocol | Specifies the protocol of listener. Possible values are HTTP or HTTPS. | `string` | `"HTTPS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_set\_id | n/a |
| identities | n/a |
| ids | n/a |
| managed\_disk\_ids | n/a |
| marketplace\_agreement\_ids | n/a |
| network\_interface\_ids | n/a |
| network\_interface\_private\_ip\_addresses | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
