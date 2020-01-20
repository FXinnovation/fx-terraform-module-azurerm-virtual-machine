output "availability_set_id" {
  value = concat(azurerm_availability_set.this.*.id, [""])[0]
}
