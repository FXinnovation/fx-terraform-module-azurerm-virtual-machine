locals {
  should_create_availability_set  = var.enabled && var.availability_set_enabled
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
  count = local.should_create_network_interface ? var.vm_count : 0

  name                = var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.network_interface_name, count.index + 1) : var.network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  network_security_group_id     = var.network_interface_network_security_group_id
  internal_dns_name_label       = var.network_interface_internal_dns_name_label
  enable_ip_forwarding          = var.network_interface_enable_ip_forwarding
  enable_accelerated_networking = var.network_interface_enable_accelerated_networking
  dns_servers                   = var.network_interface_dns_servers

  ip_configuration {
    name                          = var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.network_interface_ip_configuration_name, count.index + 1) : var.network_interface_ip_configuration_name
    subnet_id                     = var.network_interface_ip_configuration_subnet_id
    private_ip_address            = var.network_interface_ip_configuration_private_ip_address
    private_ip_address_allocation = var.network_interface_ip_configuration_private_ip_address_allocation
    private_ip_address_version    = var.network_interface_ip_configuration_private_ip_address_version
  }

  tags = merge(
    var.tags,
    var.network_interface_tags,
    {
      Terraform = "true"
    },
  )
}

###
# Virtual Machine
###

resource "azurerm_virtual_machine" "linux" {
  count = var.vm_type == "Linux" ? var.vm_count : 0

  name                  = var.vm_count > 0 ? format("%s-%0${var.num_suffix_digits}d", var.name, count.index + 1) : var.name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_exists ? ["${data.azurerm_network_interface.this.*.id[count.index]}"] : ["${azurerm_network_interface.this.*.id[count.index]}"]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.delete_data_disks_on_termination

  availability_set_id = var.availability_set_enabled ? (var.availability_set_exists ? data.azurerm_availability_set.this.*.id[0] : concat(azurerm_availability_set.this.*.id, [""])[0]) : ""

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_id != "" ? [1] : []

    content {
      id = var.storage_image_reference_id
    }
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_publisher != "" ? [1] : []

    content {
      publisher = var.storage_image_reference_publisher
      offer     = var.storage_image_reference_offer
      sku       = var.storage_image_reference_sku
      version   = var.storage_image_reference_version
    }
  }

  dynamic "storage_os_disk" {
    for_each = var.storage_os_disk_create_option == "Attach" ? [1] : []

    content {
      name                      = var.storage_os_disk_name
      caching                   = var.storage_os_disk_caching
      create_option             = var.storage_os_disk_create_option
      disk_size_gb              = var.storage_os_disk_size_gb
      managed_disk_id           = var.storage_os_managed_disk_id
      managed_disk_type         = var.storage_os_managed_disk_type
      write_accelerator_enabled = var.storage_os_write_accelerator_enabled
      os_type                   = "Linux"
    }
  }

  dynamic "storage_os_disk" {
    for_each = var.storage_os_disk_create_option == "FromImage" ? [1] : []

    content {
      name                      = var.storage_os_disk_name
      caching                   = var.storage_os_disk_caching
      create_option             = var.storage_os_disk_create_option
      disk_size_gb              = var.storage_os_disk_size_gb
      vhd_uri                   = var.storage_os_vhd_uri
      write_accelerator_enabled = var.storage_os_write_accelerator_enabled
      os_type                   = "Linux"
    }
  }

  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
    custom_data    = var.os_profile_custom_data
  }

  os_profile_linux_config {
    disable_password_authentication = var.os_profile_linux_config_disable_password_authentication

    dynamic "ssh_keys" {
      for_each = var.os_profile_linux_config_ssh_keys

      content {
        key_data = ssh_keys.key_data
        path     = ssh_keys.path
      }
    }
  }

  dynamic "plan" {
    for_each = var.plan_name != "" ? [1] : []

    content {
      name      = var.plan_name
      publisher = var.plan_publisher
      product   = var.plan_product
    }
  }

  dynamic "os_profile_secrets" {
    for_each = var.os_profile_secrets_source_vault_id != "" ? [1] : []

    content {
      source_vault_id = var.os_profile_secrets_source_vault_id

      dynamic "vault_certificates" {
        for_each = var.os_profile_secrets_vault_certificates

        content {
          certificate_url   = vault_certificates.certificate_url
          certificate_store = vault_certificates.certificate_store
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


resource "azurerm_virtual_machine" "windows" {
  count = var.vm_type == "Windows" ? var.vm_count : 0

  license_type = var.license_type

  name                  = var.vm_count > 0 ? format("%s-%${var.num_suffix_digits}d", var.name, count.index + 1) : var.name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = ["${azurerm_network_interface.this.*.id[count.index]}"]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.delete_data_disks_on_termination

  availability_set_id = var.availability_set_enabled ? (var.availability_set_exists ? data.azurerm_availability_set.this.*.id[0] : concat(azurerm_availability_set.this.*.id, [""])[0]) : ""

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_id != "" ? [1] : []

    content {
      id = var.storage_image_reference_id
    }
  }

  dynamic "storage_image_reference" {
    for_each = var.storage_image_reference_publisher != "" ? [1] : []

    content {
      publisher = var.storage_image_reference_publisher
      offer     = var.storage_image_reference_offer
      sku       = var.storage_image_reference_sku
      version   = var.storage_image_reference_version
    }
  }

  dynamic "storage_os_disk" {
    for_each = var.storage_os_disk_create_option == "Attach" ? [1] : []

    content {
      name                      = var.storage_os_disk_name
      caching                   = var.storage_os_disk_caching
      create_option             = var.storage_os_disk_create_option
      disk_size_gb              = var.storage_os_disk_size_gb
      managed_disk_id           = var.storage_os_managed_disk_id
      managed_disk_type         = var.storage_os_managed_disk_type
      write_accelerator_enabled = var.storage_os_write_accelerator_enabled
      os_type                   = "Windows"
    }
  }

  dynamic "storage_os_disk" {
    for_each = var.storage_os_disk_create_option == "FromImage" ? [1] : []

    content {
      name                      = var.storage_os_disk_name
      caching                   = var.storage_os_disk_caching
      create_option             = var.storage_os_disk_create_option
      disk_size_gb              = var.storage_os_disk_size_gb
      vhd_uri                   = var.storage_os_vhd_uri
      write_accelerator_enabled = var.storage_os_write_accelerator_enabled
      os_type                   = "Windows"
    }
  }

  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
    custom_data    = var.os_profile_custom_data
  }

  os_profile_windows_config {
    provision_vm_agent        = var.os_profile_windows_config_provision_vm_agent
    enable_automatic_upgrades = var.os_profile_windows_config_enable_automatic_upgrades
    timezone                  = var.os_profile_windows_config_timezone

    dynamic "additional_unattend_config" {
      for_each = var.additional_unattend_config_content != "" ? [1] : []

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

  dynamic "plan" {
    for_each = var.plan_name != "" ? [1] : []

    content {
      name      = var.plan_name
      publisher = var.plan_publisher
      product   = var.plan_product
    }
  }

  dynamic "os_profile_secrets" {
    for_each = var.os_profile_secrets_source_vault_id != "" ? [1] : []

    content {
      source_vault_id = var.os_profile_secrets_source_vault_id

      dynamic "vault_certificates" {
        for_each = var.os_profile_secrets_vault_certificates

        content {
          certificate_url   = vault_certificates.certificate_url
          certificate_store = vault_certificates.certificate_store
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
