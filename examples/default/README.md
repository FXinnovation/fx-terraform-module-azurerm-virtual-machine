# Default example

This will create basic resources.

## Usage
```
terraform init
terraform plan
terraform apply
terraform destroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | ~>1.42.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_id | n/a | `string` | n/a | yes |
| client\_secret | n/a | `string` | n/a | yes |
| subscription\_id | n/a | `string` | n/a | yes |
| tenant\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| availability\_set\_id | n/a |
| azurerm\_managed\_disk\_ids | n/a |
| identities | n/a |
| ids | n/a |
| network\_interface\_ids | n/a |
| network\_interface\_private\_ip\_addresses | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
