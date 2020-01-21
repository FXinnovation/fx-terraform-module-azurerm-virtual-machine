# terraform-module-azurerm-virtual-machine

## Usage
See `examples` folders for usage of this module.

## Limitation

- Any call of this module will create resources in a single resource group.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_set\_enabled | Whether or not to create an availability set. | string | `"true"` | no |
| availability\_set\_exists | If defined, the existing availability set will be used by virtual machines instead of creating a new availability set inside this module. | string | `"false"` | no |
| availability\_set\_name | Specifies the name of the availability set. Changing this forces a new resource to be created. | string | `""` | no |
| availability\_set\_tags | Tags specific to the availability set. | map | `{}` | no |
| enabled | Enable or disable module | string | `"true"` | no |
| network\_interface\_dns\_servers | List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list | list | `[]` | no |
| network\_interface\_enable\_accelerated\_networking | Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. | string | `"false"` | no |
| network\_interface\_enable\_ip\_forwarding | Enables IP Forwarding on the NIC. | string | `"false"` | no |
| network\_interface\_enabled | Whether or not to create a network interface. | string | `"true"` | no |
| network\_interface\_internal\_dns\_name\_label | Relative DNS name for this NIC used for internal communications between VMs in the same VNet. | string | `""` | no |
| network\_interface\_ip\_configuration\_name | User-defined name of the IP. | string | `""` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address | Static IP Address. | string | `""` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_allocation | Defines how a private IP address is assigned. Options are Static or Dynamic. | string | `"Dynamic"` | no |
| network\_interface\_ip\_configuration\_private\_ip\_address\_version | The IP Version to use. Possible values are IPv4 or IPv6. | string | `"IPv4"` | no |
| network\_interface\_ip\_configuration\_public\_ip\_address\_id | Reference to a Public IP Address to associate with this NIC. | string | `""` | no |
| network\_interface\_ip\_configuration\_subnet\_id | Reference to a subnet in which this NIC has been created. Required when private\_ip\_address\_version is IPv4. | string | `""` | no |
| network\_interface\_name | The name of the network interface. Changing this forces a new resource to be created. | string | `""` | no |
| network\_interface\_names | If defined, this network interfaces will be used by other virtual machines instead of creating a new network interfaces inside this module. | list | `[ "" ]` | no |
| network\_interface\_network\_security\_group\_id | The ID of the Network Security Group to associate with the network interface. | string | `""` | no |
| network\_interface\_tags | Tags specific to the network interface. | map | `{}` | no |
| num\_suffix\_digits | How many digits to use for resources names. | string | `"2"` | no |
| resource\_group\_location | pecifies the supported Azure location where the resources exist. Changing this forces a new resource to be created. | string | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created. | string | `""` | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | map | `{}` | no |
| vm\_count | How many virtual machines to create. | string | `"1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_set\_id |  |
| network\_interface\_ids |  |
| network\_interface\_mac\_addresses |  |
| network\_interface\_private\_ip\_addresses |  |
| network\_interface\_virtual\_machine\_ids |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
