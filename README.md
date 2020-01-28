# terraform-module-azurerm-virtual-machine

## Usage
See `examples` folders for usage of this module.

## Limitation

- Any call of this module will create resources in a single resource group.
- Only one network interface pre VM is possible now.
- Any network interfaces created in this module will have a single ip_configuration.
- Tags for VMs are shared among all VMs. Same thing for managed disks.
- Managed disks cannot be encrypted.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

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
| availability\_set\_tags | Tags specific to the availability set. | `map` | `{}` | no |
| boot\_diagnostics\_enabled | Should Boot Diagnostics be enabled for this Virtual Machine? | `bool` | `false` | no |
| boot\_diagnostics\_storage\_uri | The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files. | `string` | `""` | no |
| delete\_data\_disks\_on\_termination | Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? | `bool` | `false` | no |
| delete\_os\_disk\_on\_termination | Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? | `bool` | `false` | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| license\_type | Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows\_Client and Windows\_Server. | `string` | `"Windows_Server"` | no |
| managed\_disk\_cachings | Specifies the caching requirements for the Managed Disks. Possible values include None, ReadOnly and ReadWrite. | `list(string)` | <pre>[<br>  "ReadWrite"<br>]<br></pre> | no |
| managed\_disk\_count | How many additional managed disk to attach to EACH Virtual Machines. | `number` | `0` | no |
| managed\_disk\_create\_options | The methods to use when creating the Managed Disks. Possible values include: Empty, FromImage, Copy, Import, Restore. | `list(string)` | <pre>[<br>  "Empty"<br>]<br></pre> | no |
| managed\_disk\_image\_reference\_ids | IDs of an existing platform/marketplace disk image to copy when create\_option is FromImage. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "FromImage" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| managed\_disk\_names | Specifies the names of the Managed Disks. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "manage-disk"<br>]<br></pre> | no |
| managed\_disk\_os\_types | Specify values when the source of an Import or Copy operation targets a source that contains an operating system. Valid values inside the list are Linux or Windows. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Import"  on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| managed\_disk\_size\_gbs | Specifies the sizes of the Managed Disks to create in gigabytes. If create\_option is Copy or FromImage, then the value must be equal to or greater than the source's size. | `list(number)` | <pre>[<br>  5<br>]<br></pre> | no |
| managed\_disk\_source\_resource\_ids | The IDs of existing Managed Disks to copy create\_option is Copy or the recovery points to restore when create\_option is Restore. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Restore" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| managed\_disk\_source\_uris | URI to a valid VHD file to be used when create\_option is Import. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Import" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]<br></pre> | no |
| managed\_disk\_storage\_account\_types | The types of storage to use for the Managed Disks. Possible values inside the list are Standard\_LRS, Premium\_LRS, StandardSSD\_LRS or UltraSSD\_LRS. | `list(string)` | <pre>[<br>  "Standard_LRS"<br>]<br></pre> | no |
| managed\_disk\_tags | Tags specific to the Managed Disks. | `map` | `{}` | no |
| managed\_disk\_write\_accelerator\_enableds | Specifies if Write Accelerator is enabled on Managed Disks. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. | `list(bool)` | <pre>[<br>  false<br>]<br></pre> | no |
| name | Specifies the name of the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"vm"` | no |
| network\_interface\_dns\_servers | List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list | `list` | `[]` | no |
| network\_interface\_enable\_accelerated\_networking | Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. | `bool` | `false` | no |
| network\_interface\_enable\_ip\_forwarding | Enables IP Forwarding on the NIC. | `bool` | `false` | no |
| network\_interface\_enabled | Whether or not to create a network interface. | `bool` | `true` | no |
| network\_interface\_exists | If defined, will use var.network\_interface\_names to get network interfaces instead of creating a new network interfaces inside this module. | `bool` | `false` | no |
| network\_interface\_internal\_dns\_name\_label | Relative DNS name for this NIC used for internal communications between VMs in the same VNet. | `string` | `""` | no |
| network\_interface\_ip\_configuration\_name | User-defined name of the IP. | `string` | `""` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address | Static IP Address. | `string` | `""` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_allocation | Defines how a private IP address is assigned. Options are Static or Dynamic. | `string` | `"Dynamic"` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_version | The IP Version to use. Possible values are IPv4 or IPv6. | `string` | `"IPv4"` | no |
| network\_interface\_ip\_configuration\_public\_ip\_address\_id | Reference to a Public IP Address to associate with this NIC. | `string` | `""` | no |
| network\_interface\_ip\_configuration\_subnet\_id | Reference to a subnet in which this NIC has been created. Required when private\_ip\_address\_version is IPv4. | `string` | `""` | no |
| network\_interface\_name | The name of the network interface. Changing this forces a new resource to be created. | `string` | `""` | no |
| network\_interface\_names | If defined, this network interfaces will be used by other virtual machines instead of creating a new network interfaces inside this module. | `list` | <pre>[<br>  ""<br>]<br></pre> | no |
| network\_interface\_network\_security\_group\_id | The ID of the Network Security Group to associate with the network interface. | `string` | `""` | no |
| network\_interface\_tags | Tags specific to the network interface. | `map` | `{}` | no |
| num\_suffix\_digits | How many digits to use for resources names. | `number` | `2` | no |
| os\_profile\_admin\_password | The password associated with the local administrator account. | `string` | `"TO_BE_CHANGED"` | no |
| os\_profile\_admin\_username | Specifies the name of the local administrator account. | `string` | `"testadmin"` | no |
| os\_profile\_computer\_name | Specifies the name of the Virtual Machine. | `string` | `"hostname"` | no |
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
| resource\_group\_location | pecifies the supported Azure location where the resources exist. Changing this forces a new resource to be created. | `string` | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created. | `string` | `""` | no |
| storage\_image\_reference\_id | Specifies the ID of the Custom Image which the Virtual Machine should be created from. Changing this forces a new resource to be created. | `string` | `""` | no |
| storage\_image\_reference\_offer | Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"UbuntuServer"` | no |
| storage\_image\_reference\_publisher | Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"Canonical"` | no |
| storage\_image\_reference\_sku | Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"18.04-LTS"` | no |
| storage\_image\_reference\_version | Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"latest"` | no |
| storage\_os\_disk\_caching | Specifies the caching requirements for the OS Disk. Possible values include None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| storage\_os\_disk\_create\_option | Specifies how the OS Disk should be created. Possible values are Attach (managed disks only) and FromImage. | `string` | `"FromImage"` | no |
| storage\_os\_disk\_name | Specifies how the OS Disk should be created. Possible values are Attach (managed disks only) and FromImage. | `string` | `"FromImage"` | no |
| storage\_os\_disk\_size\_gb | Specifies the size of the OS Disk in gigabytes. | `number` | `30` | no |
| storage\_os\_managed\_disk\_id | SSpecifies the ID of an existing Managed Disk which should be attached as the OS Disk of this Virtual Machine. If this is set then the create\_option must be set to Attach. | `string` | `""` | no |
| storage\_os\_managed\_disk\_type | Specifies the type of Managed Disk which should be created. Possible values are Standard\_LRS, StandardSSD\_LRS or Premium\_LRS. | `string` | `"Standard_LRS"` | no |
| storage\_os\_vhd\_uri | Specifies the URI of the VHD file backing this Unmanaged OS Disk. Changing this forces a new resource to be created. | `string` | `""` | no |
| storage\_os\_write\_accelerator\_enabled | Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. | `bool` | `false` | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | `map` | `{}` | no |
| vm\_count | How many Virtual Machines to create. | `number` | `1` | no |
| vm\_size | Specifies the size of the Virtual Machines. https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json. | `string` | `"Standard_B1ls"` | no |
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
| network\_interface\_ids | n/a |
| network\_interface\_mac\_addresses | n/a |
| network\_interface\_private\_ip\_addresses | n/a |
| network\_interface\_virtual\_machine\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
