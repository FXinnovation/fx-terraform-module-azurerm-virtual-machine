# terraform-module-azurerm-virtual-machine

## Usage
See `examples` folders for usage of this module.

## Limitation

- Any call of this module will create resources in a single resource group.
- Any network interfaces created in this module will have a single ip_configuration.
- Tags for VMs are shared among all VMs. Same thing for managed disks.
- No disks can be encrypted automatically.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_capabilities\_ultra\_ssd\_enabled | Should Ultra SSD disk be enabled for this Virtual Machine? | `bool` | `false` | no |
| additional\_unattend\_content\_windows\_content | Specifies the base-64 encoded XML formatted content that is added to the unattend.xml file for the specified path and component. | `string` | `""` | no |
| additional\_unattend\_content\_windows\_setting | Specifies the name of the setting to which the content applies. Possible values are: `FirstLogonCommands` and `AutoLogon`. | `string` | `"FirstLogonCommands"` | no |
| admin\_password | The virtual machine password associated with the local administrator account. | `string` | `"Passw0rd_TO_BE_CHANGED!"` | no |
| admin\_username | Specifies the name of the virtual machine local administrator account. | `string` | `"testadmin"` | no |
| allow\_extension\_operations | Boolean flag whcih provides the information about should the extension operations be allowed on the virtual machine? Chaning this forces a new resource to be created. | `bool` | `true` | no |
| availability\_set\_enabled | Whether or not to create an availability set. | `bool` | `true` | no |
| availability\_set\_exists | If defined, the existing availability set will be used by virtual machines instead of creating a new availability set inside this module. | `bool` | `false` | no |
| availability\_set\_managed | Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic). | `bool` | `true` | no |
| availability\_set\_name | Specifies the name of the availability set. Changing this forces a new resource to be created. | `string` | `""` | no |
| availability\_set\_platform\_fault\_domain\_count | Specifies the number of fault domains that are used. | `number` | `2` | no |
| availability\_set\_platform\_update\_domain\_count | Specifies the number of update domains that are used. | `number` | `5` | no |
| availability\_set\_proximity\_placement\_group\_id | The ID of the proximity placement group to which the virtual machine should be assigned. Changing this forces a new resource to be created. | `string` | `""` | no |
| availability\_set\_tags | Tags specific to the availability set. | `map` | `{}` | no |
| boot\_diagnostics\_enabled | Boolean flag which describes whether or not enable the boot diagnostics setting for the virtual machine. | `bool` | `false` | no |
| boot\_diagnostics\_storage\_account\_uri | The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files. | `string` | `""` | no |
| certificate\_url | The Secret URL of the Key vault certificate.This can be sourced from the `secret_url` field within the `azurerm_key_vault_certificate` resource. | `string` | `""` | no |
| computer\_names | Specifies the hostname which should be used for the virtual machine.If unspecified this defaults to the value of `vm_names` filed. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| custom\_data | The Base64-Encoded custom data which should be used for the virtual machine. Changing this forces a new resource to be created. | `any` | `null` | no |
| dedicated\_host\_enabled | Boolean flag which describes whether the Decicated host id enabled or not. | `bool` | `false` | no |
| dedicated\_host\_ids | The list IDs of a dedicated host where th emachien should be run on. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| diff\_disk\_settings\_option | Specifies the Ephemeral disk settings for the OS Disk. At this time the only possible value is `local`. Changing this forces a new resource to be created. | `string` | `""` | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| eviction\_policy | Specifies what should happen when the virtual machine is evicted for the price reason when using the spot instance. At this time only supported value is `Deallocate`. Changing this forces a new resource to be created. | `string` | `"Deallocate"` | no |
| identity\_identity\_ids | A list of list of User managed identity ID's which should be assigned to the virtual machine. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| identity\_types | The list of types of Managed identity which should be assigned to the virtual machine. Possible values are `systemassigned`, `UserAssigned` and `SustemAssigned,UserAssigned`. | `list` | <pre>[<br>  ""<br>]</pre> | no |
| linux\_admin\_ssh\_keys | One or more admin ssh\_key blocks. `NOTE`: One of either `admin_password` or `admin_ssh_key must be specified`. | `list(object({ public_key = string, username = string }))` | <pre>[<br>  null<br>]</pre> | no |
| linux\_vm\_enabled | Boolean flag which describes whether or not enable the linux virtual machine resource. | `bool` | `false` | no |
| managed\_data\_disk\_cachings | Specifies the caching requirements for the Managed Disks. Possible values include None, ReadOnly and ReadWrite. | `list(string)` | <pre>[<br>  "ReadWrite"<br>]</pre> | no |
| managed\_data\_disk\_create\_options | Specifies the list of create option of the data disk such as `Empty` or `Attach`. Defaults to `Attach`. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "Attach"<br>]</pre> | no |
| managed\_data\_disk\_write\_accelerator\_enableds | Specifies if Write Accelerator is enabled on Managed Disks. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| managed\_disk\_count | How many additional managed disk to attach to EACH Virtual Machines. | `number` | `0` | no |
| managed\_disk\_create\_options | The methods to use when creating the Managed Disks. Possible values include: Empty, FromImage, Copy, Import, Restore. | `list(string)` | <pre>[<br>  "Empty"<br>]</pre> | no |
| managed\_disk\_encryption\_key\_secret\_url | Refeerence to the URL of the key vault secret used as the disk encryption key. This can be found as `id` on the `azurerm_key_vault_secret` resource. | `string` | `""` | no |
| managed\_disk\_encryption\_key\_source\_vault\_id | The URl of the key vault. This can be found as `Vault_uri` on the `azurerm_key_vault` resource. | `string` | `""` | no |
| managed\_disk\_encryption\_settings\_enabled | Boolean flag which describes whether the encryption is enabled on the managed disk or not. Changing this forces a new resource to be created. | `bool` | `false` | no |
| managed\_disk\_image\_reference\_ids | IDs of an existing platform/marketplace disk image to copy when create\_option is FromImage. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "FromImage" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_key\_encryption\_key\_key\_url | The URL to the key vault key used as the key encryption key. This can be found as `id` on the `azurerm_key_vault_key` resource. | `string` | `""` | no |
| managed\_disk\_key\_encryption\_key\_source\_valut\_id | The ID of the source key vault. | `string` | `""` | no |
| managed\_disk\_names | Specifies the names of the Managed Disks. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "vm-manage-disk"<br>]</pre> | no |
| managed\_disk\_os\_types | Specify values when the source of an Import or Copy operation targets a source that contains an operating system. Valid values inside the list are Linux or Windows. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Import"  on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  "Windows"<br>]</pre> | no |
| managed\_disk\_size\_gbs | Specifies the sizes of the Managed Disks to create in gigabytes. If create\_option is Copy or FromImage, then the value must be equal to or greater than the source's size. | `list(number)` | <pre>[<br>  5<br>]</pre> | no |
| managed\_disk\_source\_resource\_ids | The IDs of existing Managed Disks to copy create\_option is Copy or the recovery points to restore when create\_option is Restore. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Copy"/"Restore" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_source\_uris | URI to a valid VHD file to be used when create\_option is Import. CAREFUL: if you create multiple Managed Disks with different create\_option, make sure this list matches with the disks having "Import" on (meaning this list may have empty values). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| managed\_disk\_storage\_account\_types | The types of storage to use for the Managed Disks. Possible values inside the list are Standard\_LRS, Premium\_LRS, StandardSSD\_LRS or UltraSSD\_LRS. | `list(string)` | <pre>[<br>  "Standard_LRS"<br>]</pre> | no |
| managed\_disk\_tags | Tags specific to the Managed Disks. | `map` | `{}` | no |
| marketplace\_agreement\_offers | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| marketplace\_agreement\_plans | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| marketplace\_agreement\_publishers | Should Ultra SSD disk be enabled for this Virtual Machine? | `list` | `[]` | no |
| max\_bid\_price | The maximum price youre willing to pay for the vitual machine, in US Dollard; which must be greater tha the current spot price. If this bid price falls below the current spot price the virtual machine will be evicted using the `evction_policy`. Defaults to `-1`, which means that the virtual machine should not be evicted for the price reason. | `string` | `"-1"` | no |
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
| network\_interface\_ip\_configuration\_primary | Boolean flag which describes if ip configuration is primary one or not. Must be `true` for the first `ip_configuration` when multiple are specified. Defaults to `fasle`. | `list(bool)` | <pre>[<br>  true<br>]</pre> | no |
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
| num\_suffix\_digits | How many digits to use for resources names. | `number` | `0` | no |
| os\_disk\_caching | Specifies the caching requirements for the OS Disk. Possible values include None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| os\_disk\_encryption\_set\_id | The ID of the Disk encryption set which should be used to encrypt the OS disk. `NOTE: The Disk encryption set must have the `READER` role assignmnet scoped on the key vault- in addition to an access policy to the key vault`. | `any` | `null` | no |
| os\_disk\_size\_gb | Specifies the size of the OS Disk in gigabytes. | `number` | `30` | no |
| os\_disk\_storage\_account\_type | The type of storage account which should back the internal OS disk. Possible values are `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| plan\_name | Specifies the name of the image from the marketplace. | `string` | `""` | no |
| plan\_product | Specifies the product of the image from the marketplace. | `string` | `""` | no |
| plan\_publisher | Specifies the publisher of the image. | `string` | `""` | no |
| priority | Specfies the priority of the virtual machine. Posssible values are `regular` an `Spot`. Defaults to `Regular`. Changing this forces a new resourec to be created. | `string` | `"Regular"` | no |
| provision\_vm\_agent | Boolean flag which descibes should the Azure VM agent to provisioned on the virtual machine or not. Defaults to `true`. Changing this forces a new resource to be created. | `bool` | `true` | no |
| proximity\_placement\_group\_id | The ID of the proximity placement group which the virtual machine should be assigned to. Changing this forces a new resource to be created. | `any` | `null` | no |
| resource\_group\_location | Specifies the supported Azure location where the resources exist. Changing this forces a new resource to be created. | `string` | `"eastus"` | no |
| resource\_group\_name | The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created. | `string` | `""` | no |
| secret\_key\_vault\_id | The ID of the key vault from where all the certificates or secrets are stored. This can be source from `id` filed from the `azurerm_key_vault` resource. | `string` | `""` | no |
| source\_image\_id | The ID of the image which the virtual machine should be created from. Changing this forces a new resource to be created. | `any` | `null` | no |
| source\_image\_reference\_offer | Specifies the offer of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"WindowsServer"` | no |
| source\_image\_reference\_publisher | Specifies the publisher of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"MicrosoftWindowsServer"` | no |
| source\_image\_reference\_sku | Specifies the SKU of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"2016-Datacenter"` | no |
| source\_image\_reference\_version | Specifies the version of the image used to create the virtual machine. Changing this forces a new resource to be created. | `string` | `"latest"` | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | `map` | `{}` | no |
| vm\_count | How many Virtual Machines to create. | `number` | `1` | no |
| vm\_extension\_auto\_upgarde\_minor\_version | Boolean flag list which describes if the platform deploys the latest minor version update to the `type_handler_version` specified. | `list` | <pre>[<br>  false<br>]</pre> | no |
| vm\_extension\_count | How many extensions have to be configured to EACH virtual machine. | `number` | `1` | no |
| vm\_extension\_names | The list of names of virtual machine extension peering. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extension\_protected\_settings | The list of protected settings passed to the extension, like settings, these are specified as a JSON object in a string. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extension\_publishers | The List of publisher of the extensions, available publisher can be found by using the Azure CLI `via: az vm extension image list --location westus -o table`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extension\_settings | List of settings passed to the extension, these are specified as a JSON object in a string. Please `Note`: Certain VM Extensions require that the keys in the `settings` block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the `JsonADDomainExtension extension`, the keys are expected to be in `TitleCase`.). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extension\_tags | Tags which will be associated to the virtual machine extensions. | `map` | `{}` | no |
| vm\_extension\_type\_handler\_versions | Specifies the list of version of the extensions to use, available versions can be found using Azure CLI. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extension\_types | List which specifies the type of extension, available types for a publisher can be found using Azure CLI. `NOTE`: The `Publisher` and `Type` of virtual machine extension can be found using the Azure CLI, via: `shell $ az vm extension image list --location westus -o table`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vm\_extensions\_enabled | Booelan flag which describes whether or not to enable the virtual machine extensions. | `bool` | `false` | no |
| vm\_names | Specifies the names of the Virtual Machine. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "vm"<br>]</pre> | no |
| vm\_size | Specifies the size of the Virtual Machines. https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Ftoc.json. | `string` | `"Standard_B2ms"` | no |
| vm\_tags | Tags specific to the Virtual Machines. | `map` | `{}` | no |
| vm\_type | The type of Virtual Machine. Can be either "Linux" or "Windows". | `string` | `"Windows"` | no |
| windows\_certificate\_store | The certificate store on the windows virtual machine where the certificate should be added. | `string` | `""` | no |
| windows\_enable\_automatic\_updates | Specifies if the automatic updates are enabled for the windows virtual machine. Changing this forces a new resource to be created. | `bool` | `false` | no |
| windows\_license\_type | Specifies the type of on-premise license (also know as `Azure Hybrid Use Benefits`) which should be used for the virtual machine. Possible values are `None`, `Windows_client` and `Windows_Server`. Changing this forces a new resource to be created. | `string` | `""` | no |
| windows\_timezone | Specifies the timezone which should be used by the virtual machine. The possible values are defined over here: https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/ | `string` | `"UTC"` | no |
| windows\_vm\_enabled | Whether or not create windows virtual machine. | `bool` | `false` | no |
| winrm\_listener\_certificate\_url | The ID of the Key Vault Secret which contains the encrypted Certificate which should be installed on the Virtual Machine. This certificate must also be specified in the vault\_certificates block within the os\_profile\_secrets block. | `string` | `""` | no |
| winrm\_listener\_protocol | Specifies the protocol of listener. Possible values are `Http` or `Https`. | `string` | `"Http"` | no |
| zone | The zone in which the virtual machine should be created. Changing this forces a new resource to be created. | `number` | `null` | no |
| zone\_enabled | Boolean flag which describes whether or not enable the zone. Changing this will force a new resource to be created. | `bool` | `false` | no |

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
