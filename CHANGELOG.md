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
