locals {
  should_create_availability_set  = var.enabled && var.availability_set_enabled && ! var.availability_set_exists
  should_create_network_interface = var.enabled && var.network_interface_enabled && ! var.network_interface_exists && var.vm_count > 0
  storage_os_disk_name            = var.storage_os_disk_name != "" ? var.storage_os_disk_name : var.name
  supports_encryption_set         = var.resource_group_location == "East US 2" || var.resource_group_location == "Canada Central" || var.resource_group_location == "West Central US" || var.resource_group_location == "North Europe"
}

###
# Availability set
###

resource "azurerm_availability_set" "this" {
  count = local.should_create_availability_set ? 1 : 0

  name                = var.availability_set_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

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

  name                = var.network_interface_count * var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.network_interface_names, count.index % var.network_interface_count), count.index + 1) : element(var.network_interface_names, count.index % var.network_interface_count)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  network_security_group_id     = element(var.network_interface_network_security_group_ids, count.index % var.network_interface_count)
  internal_dns_name_label       = var.network_interface_count * var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", element(var.network_interface_internal_dns_name_labels, count.index % var.network_interface_count), count.index + 1) : element(var.network_interface_internal_dns_name_labels, count.index % var.network_interface_count)
  enable_ip_forwarding          = element(var.network_interface_enable_ip_forwardings, count.index % var.network_interface_count)
  enable_accelerated_networking = element(var.network_interface_enable_accelerated_networkings, count.index % var.network_interface_count)
  dns_servers                   = element(var.network_interface_dns_servers, count.index % var.network_interface_count)

  ip_configuration {
    name                          = element(var.network_interface_ip_configuration_names, count.index)
    subnet_id                     = element(var.network_interface_ip_configuration_subnet_ids, count.index)
    private_ip_address            = element(var.network_interface_ip_configuration_private_ip_addresses, count.index)
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
  ip_configuration_name         = element(var.network_interface_ip_configuration_names, element(var.network_interface_application_security_group_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  application_security_group_id = element(var.network_interface_application_security_group_ids, count.index).application_security_group_id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "this" {
  count = var.enabled ? var.network_interface_application_gateway_backend_address_pool_count * var.network_interface_count : 0

  network_interface_id    = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_application_gateway_backend_address_pool_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name   = element(var.network_interface_ip_configuration_names, element(var.network_interface_application_security_group_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  backend_address_pool_id = element(var.network_interface_application_gateway_backend_address_pool_ids, count.index).application_gateway_backend_address_pool_id
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count = var.enabled ? var.network_interface_backend_address_pool_count * var.network_interface_count : 0

  network_interface_id    = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_backend_address_pool_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name   = element(var.network_interface_ip_configuration_names, element(var.network_interface_backend_address_pool_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  backend_address_pool_id = element(var.network_interface_backend_address_pool_ids, count.index).backend_address_pool_id
}

resource "azurerm_network_interface_nat_rule_association" "this" {
  count = var.enabled ? var.network_interface_nat_rule_association_count * var.network_interface_count : 0

  network_interface_id  = element((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), element(var.network_interface_nat_rule_association_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
  ip_configuration_name = element(var.network_interface_ip_configuration_names, element(var.network_interface_nat_rule_association_ids, count.index).network_interface_index + floor(count.index / var.network_interface_count))
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
# Virtual Machine
###

resource "azurerm_virtual_machine" "this" {
  count = var.enabled ? var.vm_count : 0

  license_type = var.vm_type == "Windows" ? var.license_type : null

  name                         = var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", var.name, count.index + 1) : var.name
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  network_interface_ids        = element(chunklist((var.network_interface_exists ? data.azurerm_network_interface.this.*.id : azurerm_network_interface.this.*.id), var.network_interface_count), count.index)
  primary_network_interface_id = var.network_interface_exists ? data.azurerm_network_interface.this.*.id[count.index * var.network_interface_count] : azurerm_network_interface.this.*.id[count.index * var.network_interface_count]
  vm_size                      = var.vm_size

  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.delete_data_disks_on_termination

  availability_set_id = var.availability_set_enabled ? (var.availability_set_exists ? data.azurerm_availability_set.this.*.id[0] : concat(azurerm_availability_set.this.*.id, [
  ""])[0]) : ""

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_id != "" ? [
    1] : []

    content {
      id = var.storage_image_reference_id
    }
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_publisher != "" ? [
    1] : []

    content {
      publisher = var.storage_image_reference_publisher
      offer     = var.storage_image_reference_offer
      sku       = var.storage_image_reference_sku
      version   = var.storage_image_reference_version
    }
  }

  storage_os_disk {
    name                      = var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", local.storage_os_disk_name, count.index + 1) : local.storage_os_disk_name
    caching                   = var.storage_os_disk_caching
    create_option             = var.storage_os_disk_create_option
    disk_size_gb              = var.storage_os_disk_size_gb
    managed_disk_id           = var.storage_os_disk_create_option == "Attach" ? var.storage_os_managed_disk_id : null
    managed_disk_type         = var.storage_os_disk_create_option == "Attach" ? var.storage_os_managed_disk_type : null
    vhd_uri                   = var.storage_os_disk_create_option == "FromImage" ? var.storage_os_vhd_uri : null
    write_accelerator_enabled = var.storage_os_write_accelerator_enabled
    os_type                   = var.vm_type == "Windows" ? "Windows" : "Linux"
  }

  os_profile {
    computer_name  = var.vm_type == "Windows" ? substr((var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", var.name, count.index + 1) : var.name), -15, 15) : var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", var.name, count.index + 1) : var.name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
    custom_data    = var.os_profile_custom_data
  }

  dynamic "os_profile_linux_config" {
    for_each = var.vm_type == "Linux" ? [
    1] : []
    content {
      disable_password_authentication = var.os_profile_linux_config_disable_password_authentication

      dynamic "ssh_keys" {
        for_each = var.os_profile_linux_config_ssh_keys

        content {
          key_data = ssh_keys.value.key_data
          path     = format("/home/%s/.ssh/authorized_keys", var.os_profile_admin_username)
        }
      }
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = var.vm_type == "Windows" ? [
    1] : []

    content {
      provision_vm_agent        = var.os_profile_windows_config_provision_vm_agent
      enable_automatic_upgrades = var.os_profile_windows_config_enable_automatic_upgrades
      timezone                  = var.os_profile_windows_config_timezone

      dynamic "additional_unattend_config" {
        for_each = var.additional_unattend_config_content != "" ? [
        1] : []

        content {
          pass         = "oobeSystem"
          component    = "Microsoft-Windows-Shell-Setup"
          setting_name = var.additional_unattend_config_setting_name
          content      = var.additional_unattend_config_content
        }
      }

      winrm {
        protocol        = var.winrm_protocol
        certificate_url = var.winrm_certificate_url
      }
    }
  }

  dynamic "plan" {
    for_each = var.plan_name != "" ? [
    1] : []

    content {
      name      = var.plan_name
      publisher = var.plan_publisher
      product   = var.plan_product
    }
  }

  dynamic "os_profile_secrets" {
    for_each = var.os_profile_secrets_source_vault_id != "" ? [
    1] : []

    content {
      source_vault_id = var.os_profile_secrets_source_vault_id

      dynamic "vault_certificates" {
        for_each = var.os_profile_secrets_vault_certificates

        content {
          certificate_url   = vault_certificates.value.certificate_url
          certificate_store = vault_certificates.value.certificate_store
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

  name                 = var.managed_disk_count * var.vm_count > 0 ? format("%s%0${var.num_suffix_digits}d", var.name, count.index + 1) : element(var.managed_disk_names, floor(count.index / var.vm_count) % var.managed_disk_count)
  storage_account_type = element(var.managed_disk_storage_account_types, floor(count.index / var.vm_count) % var.managed_disk_count)
  disk_size_gb         = element(var.managed_disk_size_gbs, floor(count.index / var.vm_count) % var.managed_disk_count)

  create_option = element(var.managed_disk_create_options, floor(count.index / var.vm_count) % var.managed_disk_count)

  image_reference_id = element(var.managed_disk_image_reference_ids, floor(count.index / var.vm_count) % var.managed_disk_count)
  source_resource_id = element(var.managed_disk_source_resource_ids, floor(count.index / var.vm_count) % var.managed_disk_count)
  source_uri         = element(var.managed_disk_source_uris, floor(count.index / var.vm_count) % var.managed_disk_count)
  os_type            = element(var.managed_disk_os_types, floor(count.index / var.vm_count) % var.managed_disk_count)

  disk_encryption_set_id = local.supports_encryption_set ? element(azurerm_disk_encryption_set.this.*.id, count.index) : null

  dynamic "encryption_settings" {
    for_each = local.supports_encryption_set ? [0] : [1]

    content {
      enabled = true

      dynamic "disk_encryption_key" {
        for_each = var.managed_disk_disk_encryption_key_secret_urls

        content {
          secret_url      = element(var.managed_disk_disk_encryption_key_secret_urls, floor(count.index / var.vm_count) % var.managed_disk_count)
          source_vault_id = var.managed_disk_source_vault_id
        }
      }

      dynamic "key_encryption_key" {
        for_each = var.managed_disk_disk_encryption_key_secret_urls

        content {
          key_url         = element(var.managed_disk_key_encryption_key_key_urls, floor(count.index / var.vm_count) % var.managed_disk_count)
          source_vault_id = var.managed_disk_source_vault_id
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

resource "azurerm_disk_encryption_set" "this" {
  count = var.enabled && local.supports_encryption_set && var.managed_disk_count > 0 ? var.managed_disk_count * var.vm_count : 0

  name = var.managed_disk_count * var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.disk_encryption_set_names, count.index + 1) : element(var.disk_encryption_set_names, floor(count.index / var.vm_count) % var.managed_disk_count)

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  key_vault_key_id = var.disk_encryption_set_key_vault_key_id

  tags = merge(
    var.tags,
    var.disk_encryption_set_tags,
    {
      Terraform = "true"
    },
  )
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  count = var.enabled && var.vm_count > 0 ? var.managed_disk_count * var.vm_count : 0

  managed_disk_id    = azurerm_managed_disk.this.*.id[count.index]
  virtual_machine_id = azurerm_virtual_machine.this.*.id[count.index % var.vm_count]

  lun                       = count.index
  caching                   = element(var.managed_disk_cachings, floor(count.index / var.vm_count) % var.managed_disk_count)
  write_accelerator_enabled = element(var.managed_disk_write_accelerator_enableds, floor(count.index / var.vm_count) % var.managed_disk_count)
}
