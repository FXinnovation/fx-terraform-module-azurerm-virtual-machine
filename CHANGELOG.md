1.1.0 /2020-04-29
=================
* feat: Add `azurerm_virtual_machine_extension` resource for OSDisk encryption specifically.

1.0.0 /2020-04-29
=================

* feat: Refactor the module to include the new `aurerm_windows_virtual_machine` and azurerm_linux_virtual_machine` resource
* feat: Update the `azurerm` provider version to latest

0.5.2 /2020-03-28
=================

* feat: Update provider version to `1.44.0`

0.5.1 / 2020-03-09
==================

 * fix: changed condition on vm_count to allow custom names of singular VM

0.5.0 / 2020-02-11
==================

 * feat: adds marketplace agreement resource
 * feat: allows to set platform update/fault domain count for availability sets

0.4.0 / 2020-02-10
==================

 * fix: makes sure network interface associations works as intended
 * feat: outputs are now organized in maps: vm_id => values
 * feat: IP configuration names does not iterate anymore
 * feat: default names does not contain dashes anymore
 * feat: storage_os_disk_name now defaults to VM name

0.3.0 / 2020-02-05
==================

 * feat: allows network interfaces associations: NAT rules, security groups and backend address pools.

0.2.0 / 2020-02-03
==================

 * feat: allows multiple network interfaces per Virtual Machine

0.1.0 / 2020-01-29
==================

 * refactor: Virtual machine resource is now unique (VS split for Linux & Windows)

0.0.0 / 2020-01-29
==================

 * feat: adds availability set
 * feat: adds network interface
 * feat: adds X virtual machines
 * feat: adds X disks for X virtual machines
