# terraform-module-azurerm-virtual-machine

## Usage
See `examples` folders for usage of this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_set\_enabled | Whether or not to create an availability set. | string | `"true"` | no |
| availability\_set\_name | Specifies the name of the availability set. Changing this forces a new resource to be created. | string | `""` | no |
| availability\_set\_tags | Tags specific to the availability set. | map | `{}` | no |
| azurerm\_resource\_group\_location | pecifies the supported Azure location where the resources exist. Changing this forces a new resource to be created. | string | `""` | no |
| azurerm\_resource\_group\_name | The name of the resource group in which to create the resources in this module. Changing this forces a new resource to be created. | string | `""` | no |
| enabled | Enable or disable module | string | `"true"` | no |
| tags | Tags shared by all ressources of this module. Will be merged with any other specific tags by resource | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability\_set\_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
