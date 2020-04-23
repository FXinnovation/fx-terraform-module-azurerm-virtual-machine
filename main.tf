locals {
  should_create_availability_set  = var.enabled && var.availability_set_enabled && ! var.availability_set_exists
  should_create_network_interface = var.enabled && var.network_interface_enabled && ! var.network_interface_exists && var.vm_count > 0
}

###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = local.should_create_availability_set ? 1 : 0

  name                = var.availability_set_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  platform_update_domain_count = var.availability_set_platform_update_domain_count
  platform_fault_domain_count  = var.availability_set_platform_fault_domain_count
  proximity_placement_group_id = var.availability_set_proximity_placement_group_id

  managed = var.availability_set_managed

  tags = merge(
    var.tags,
    var.availability_set_tags,
    {
      Terraform = "true"
    },
  )
}

###
# Network Interface
###

resource "azurerm_network_interface" "this" {
  count = local.should_create_network_interface ? var.network_interface_count * var.vm_count : 0

  name                = var.num_suffix_digits > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.network_interface_names, count.index % var.network_interface_count), count.index + 1) : element(var.network_interface_names, count.index)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  internal_dns_name_label       = var.num_suffix_digits == 0 ? format("%s%0${var.num_suffix_digits}d", element(var.network_interface_internal_dns_name_labels, count.index % var.network_interface_count), count.index + 1) : element(var.network_interface_internal_dns_name_labels, count.index % var.network_interface_count)
  enable_ip_forwarding          = element(var.network_interface_enable_ip_forwardings, count.index)
  enable_accelerated_networking = element(var.network_interface_enable_accelerated_networkings, count.index)
  dns_servers                   = element(var.network_interface_dns_servers, count.index)

  ip_configuration {
    name                          = element(var.network_interface_ip_configuration_names, count.index)
    primary                       = element(var.network_interface_ip_configuration_primary, count.index)
    public_ip_address_id          = element(var.network_interface_ip_configuration_public_ip_address_ids, count.index)
    subnet_id                     = element(var.network_interface_ip_configuration_private_ip_address_versions, count.index) == "IPv4" ? element(var.network_interface_ip_configuration_subnet_ids, count.index) : null
    private_ip_address            = element(var.network_interface_ip_configuration_private_ip_address_allocations, count.index) == "Static" ? element(var.network_interface_ip_configuration_private_ip_addresses, count.index) : null
    private_ip_address_allocation = element(var.network_interface_ip_configuration_private_ip_address_allocations, count.index)
    private_ip_address_version    = element(var.network_interface_ip_configuration_private_ip_address_versions, count.index)
  }


  tags = merge(
    var.tags,
    var.network_interface_tags,
    {
      Terraform = "true"
    },
  )
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  count = var.enabled ? var.network_interface_application_security_group_count * var.network_interface_count : 0

  network_interface_id          = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_application_security_group_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  application_security_group_id = element(var.network_interface_application_security_group_ids, count.index).application_security_group_id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "this" {
  count = var.enabled ? var.network_interface_application_gateway_backend_address_pool_count * var.network_interface_count : 0

  network_interface_id    = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_application_gateway_backend_address_pool_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name   = element(var.network_interface_ip_configuration_names, count.index)
  backend_address_pool_id = element(var.network_interface_application_gateway_backend_address_pool_ids, count.index).application_gateway_backend_address_pool_id
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count = var.enabled ? var.network_interface_backend_address_pool_count * var.network_interface_count : 0

  network_interface_id    = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_backend_address_pool_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name   = element(var.network_interface_ip_configuration_names, count.index)
  backend_address_pool_id = element(var.network_interface_backend_address_pool_ids, count.index).backend_address_pool_id
}

resource "azurerm_network_interface_nat_rule_association" "this" {
  count = var.enabled ? var.network_interface_nat_rule_association_count * var.network_interface_count : 0

  network_interface_id  = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_nat_rule_association_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name = element(var.network_interface_ip_configuration_names, count.index)
  nat_rule_id           = element(var.network_interface_nat_rule_association_ids, count.index).nat_rule_id
}

###
# Marketplace Agreement
###

resource "azurerm_marketplace_agreement" "this" {
  count = var.enabled && length(var.marketplace_agreement_publishers) > 0 ? length(var.marketplace_agreement_publishers) : 0

  publisher = element(var.marketplace_agreement_publishers, count.index)
  offer     = element(var.marketplace_agreement_offers, count.index)
  plan      = element(var.marketplace_agreement_plans, count.index)
}

###
# Windows virtual Machine
###

resource "azurerm_windows_virtual_machine" "this" {
  count = var.enabled && var.windows_vm_enabled ? var.vm_count : 0

  name                         = var.num_suffix_digits > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.vm_names, count.index), count.index + 1) : element(var.vm_names, count.index)
  zone                         = var.zone_enabled ? var.zone : null
  size                         = var.vm_size
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  admin_username               = var.windows_admin_username
  admin_password               = var.windows_admin_password
  network_interface_ids        = element(chunklist((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), var.network_interface_count), count.index)
  allow_extension_operations   = var.allow_extension_operations
  timezone                     = var.windows_timezone
  priority                     = var.priority
  custom_data                  = var.custom_data
  license_type                 = var.windows_license_type
  computer_name                = element(var.computer_names, count.index) == null ? element(var.vm_names, count.index) : element(var.computer_names, count.index)
  max_bid_price                = var.priority == "Spot" ? var.max_bid_price : null
  eviction_policy              = var.priority == "Spot" ? var.eviction_policy : null
  source_image_id              = var.source_image_id
  dedicated_host_id            = var.dedicated_host_enabled ? element(var.dedicated_host_ids, count.index) : null
  provision_vm_agent           = var.provision_vm_agent
  availability_set_id          = var.zone_enabled != true && var.availability_set_enabled ? (var.availability_set_exists ? data.azurerm_availability_set.this.*.id[0] : azurerm_availability_set.this.*.id[0]) : null
  enable_automatic_updates     = var.windows_enable_automatic_updates
  proximity_placement_group_id = var.proximity_placement_group_id

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_enabled == true ? [1] : []

    content {
      storage_account_uri = var.boot_diagnostics_storage_account_uri
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null && var.source_image_reference_publisher != "" ? [1] : []

    content {
      publisher = var.source_image_reference_publisher
      offer     = var.source_image_reference_offer
      sku       = var.source_image_reference_sku
      version   = var.source_image_reference_version
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content_windows_content != "" ? [1] : []

    content {
      content = var.additional_unattend_content_windows_content
      setting = var.additional_unattend_content_windows_setting
    }
  }

  dynamic "identity" {
    for_each = element(var.identity_types, count.index) != "" ? [1] : []

    content {
      type         = element(var.identity_types, count.index)
      identity_ids = element(var.identity_types, count.index) == "UserAssigned" ? element(var.identity_identity_ids, count.index) : null
    }
  }

  dynamic "os_disk" {
    for_each = var.os_disk_caching != "" ? [1] : []

    content {
      name                      = format("%s-OSDisk", element(var.vm_names, count.index))
      caching                   = var.os_disk_caching
      storage_account_type      = var.os_disk_storage_account_type
      disk_size_gb              = var.os_disk_size_gb
      disk_encryption_set_id    = var.os_disk_encryption_set_id
      write_accelerator_enabled = var.os_disk_storage_account_type == "Premium_LRS" ? true : false

      dynamic "diff_disk_settings" {
        for_each = var.diff_disk_settings_option != "" ? [1] : []

        content {
          option = var.diff_disk_settings_option
        }
      }
    }
  }

  dynamic "plan" {
    for_each = var.plan_name != "" ? [1] : []

    content {
      name      = var.plan_name
      product   = var.plan_product
      publisher = var.plan_publisher
    }
  }

  dynamic "secret" {
    for_each = var.secret_key_vault_id != "" ? [1] : []

    content {
      key_vault_id = var.secret_key_vault_id

      dynamic "certificate" {
        for_each = var.windows_certificate_store != "" ? [1] : []

        content {
          store = var.windows_certificate_store
          url   = var.certificate_url
        }
      }
    }
  }

  winrm_listener {
    protocol        = var.winrm_listener_protocol
    certificate_url = var.winrm_listener_protocol == "Https" ? var.winrm_listener_certificate_url : null
  }

  tags = merge(
    var.tags,
    var.vm_tags,
    {
      Terraform = "true"
    },
  )
}

###
# Linux virtual machine
###

resource "azurerm_linux_virtual_machine" "this" {
  count = var.enabled && var.linux_vm_enabled ? var.vm_count : 0

  name                            = var.num_suffix_digits > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.vm_names, count.index), count.index + 1) : element(var.vm_names, count.index)
  zone                            = var.zone_enabled ? var.zone : null
  size                            = var.vm_size
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  admin_username                  = var.linux_admin_username
  admin_password                  = var.linux_admin_password
  network_interface_ids           = element(chunklist((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), var.network_interface_count), count.index)
  allow_extension_operations      = var.allow_extension_operations
  priority                        = var.priority
  custom_data                     = var.custom_data
  computer_name                   = element(var.computer_names, count.index) == null ? element(var.vm_names, count.index) : element(var.computer_names, count.index)
  max_bid_price                   = var.priority == "Spot" ? var.max_bid_price : null
  eviction_policy                 = var.priority == "Spot" ? var.eviction_policy : null
  source_image_id                 = var.source_image_id
  dedicated_host_id               = var.dedicated_host_enabled ? element(var.dedicated_host_ids, count.index) : null
  provision_vm_agent              = var.provision_vm_agent
  availability_set_id             = var.availability_set_enabled ? (var.availability_set_exists ? data.azurerm_availability_set.this.*.id[0] : azurerm_availability_set.this.*.id[0]) : null
  proximity_placement_group_id    = var.proximity_placement_group_id
  disable_password_authentication = var.linux_admin_password == "" ? true : false

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_enabled == true ? [1] : []

    content {
      storage_account_uri = var.boot_diagnostics_storage_account_uri
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference_publisher != "" ? [1] : []

    content {
      publisher = var.source_image_reference_publisher
      offer     = var.source_image_reference_offer
      sku       = var.source_image_reference_sku
      version   = var.source_image_reference_version
    }
  }

  dynamic "admin_ssh_key" {
    for_each = var.linux_admin_password == "" ? var.linux_admin_ssh_keys : []

    content {
      public_key = admin_ssh_key.value.public_key
      username   = admin_ssh_key.value.username
    }
  }

  dynamic "identity" {
    for_each = element(var.identity_types, count.index) != "" ? [1] : []

    content {
      type         = element(var.identity_types, count.index)
      identity_ids = element(var.identity_types, count.index) == "UserAssigned" ? element(var.identity_identity_ids, count.index) : null
    }
  }

  dynamic "os_disk" {
    for_each = var.os_disk_caching != "" ? [1] : []

    content {
      name                      = format("%s-OSDisk", element(var.vm_names, count.index))
      caching                   = var.os_disk_caching
      storage_account_type      = var.os_disk_storage_account_type
      disk_encryption_set_id    = var.os_disk_encryption_set_id
      disk_size_gb              = var.os_disk_size_gb
      write_accelerator_enabled = var.os_disk_storage_account_type == "Premium_LRS" ? true : false

      dynamic "diff_disk_settings" {
        for_each = var.diff_disk_settings_option != "" ? [1] : []

        content {
          option = var.diff_disk_settings_option
        }
      }
    }
  }

  dynamic "plan" {
    for_each = var.plan_name != "" ? [1] : []

    content {
      name      = var.plan_name
      product   = var.plan_product
      publisher = var.plan_publisher
    }
  }

  dynamic "secret" {
    for_each = var.secret_key_vault_id != "" ? [1] : []

    content {
      key_vault_id = var.secret_key_vault_id

      dynamic "certificate" {
        for_each = var.certificate_url != "" ? [1] : []

        content {
          url = var.certificate_url
        }
      }
    }
  }

  tags = merge(
    var.tags,
    var.vm_tags,
    {
      Terraform = "true"
    },
  )
}


###
# Managed Disks
###

resource "azurerm_managed_disk" "this" {
  count = var.enabled && var.managed_disk_count > 0 ? var.managed_disk_count * var.vm_count : 0

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  name                 = var.num_suffix_digits > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.managed_disk_names, floor(count.index / var.vm_count) % var.managed_disk_count), count.index) : element(var.managed_disk_names, count.index)
  storage_account_type = element(var.managed_disk_storage_account_types, floor(count.index / var.vm_count) % var.managed_disk_count)
  disk_size_gb         = element(var.managed_disk_size_gbs, floor(count.index / var.vm_count) % var.managed_disk_count)

  create_option = element(var.managed_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count)

  image_reference_id = element(var.managed_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count) == "FromImage" ? element(var.managed_disk_image_reference_ids, floor(count.index / var.vm_count) % var.managed_disk_count) : null
  source_resource_id = element(var.managed_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count) == "Copy" ? element(var.managed_disk_source_resource_ids, floor(count.index / var.vm_count) % var.managed_disk_count) : null
  source_uri         = element(var.managed_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count) == "Import" ? element(var.managed_disk_source_uris, floor(count.index / var.vm_count) % var.managed_disk_count) : null

  os_type = element(var.managed_disk_os_types, floor(count.index / var.vm_count) % var.managed_disk_count)

  dynamic "encryption_settings" {
    for_each = var.managed_disk_encryption_settings_enabled != "" ? [1] : []

    content {
      enabled = var.managed_disk_encryption_settings_enabled

      dynamic "disk_encryption_key" {
        for_each = var.managed_disk_encryption_key_secret_url != "" ? [1] : []

        content {
          secret_url      = var.managed_disk_encryption_key_secret_url
          source_vault_id = var.managed_disk_encryption_key_source_vault_id
        }
      }

      dynamic "key_encryption_key" {
        for_each = var.managed_disk_key_encryption_key_source_valut_id != "" ? [1] : []

        content {
          key_url         = var.managed_disk_key_encryption_key_key_url
          source_vault_id = var.managed_disk_key_encryption_key_source_valut_id
        }
      }
    }
  }

  tags = merge(
    var.tags,
    var.managed_disk_tags,
    {
      Terraform = "true"
    },
  )
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  count = var.enabled && var.vm_count > 0 ? var.managed_disk_count * var.vm_count : 0

  managed_disk_id    = element(azurerm_managed_disk.this.*.id, count.index)
  virtual_machine_id = var.vm_type == "Windows" ? element(concat(azurerm_windows_virtual_machine.this.*.id, [""]), count.index % var.vm_count) : element(concat(azurerm_linux_virtual_machine.this.*.id, [""]), count.index % var.vm_count)

  lun                       = count.index
  caching                   = element(var.managed_data_disk_cachings, floor(count.index / var.vm_count) % var.managed_disk_count)
  create_option             = element(var.managed_data_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count)
  write_accelerator_enabled = element(var.managed_data_disk_write_accelerator_enableds, floor(count.index / var.vm_count) % var.managed_disk_count)
}

###
# Virtual machine extensions
###

resource "azurerm_virtual_machine_extension" "this_extension" {
  count = var.enabled && var.vm_extensions_enabled ? var.vm_extension_count * var.vm_count : 0

  name                       = element(var.vm_extension_names, floor(count.index / var.vm_count) % var.vm_extension_count)
  type                       = element(var.vm_extension_types, floor(count.index / var.vm_count) % var.vm_extension_count)
  settings                   = element(var.vm_extension_settings, floor(count.index / var.vm_count) % var.vm_extension_count)
  publisher                  = element(var.vm_extension_publishers, floor(count.index / var.vm_count) % var.vm_extension_count)
  protected_settings         = element(var.vm_extension_protected_settings, floor(count.index / var.vm_count) % var.vm_extension_count)
  virtual_machine_id         = var.vm_type == "Windows" ? element(concat(azurerm_windows_virtual_machine.this.*.id, [""]), count.index % var.vm_count) : element(concat(azurerm_linux_virtual_machine.this.*.id, [""]), count.index % var.vm_count)
  type_handler_version       = element(var.vm_extension_type_handler_versions, floor(count.index / var.vm_count) % var.vm_extension_count)
  auto_upgrade_minor_version = element(var.vm_extension_auto_upgarde_minor_version, floor(count.index / var.vm_count) % var.vm_extension_count)

  tags = merge(
    var.tags,
    var.vm_extension_tags,
    {
      Terraform = "true"
    },
  )
}
