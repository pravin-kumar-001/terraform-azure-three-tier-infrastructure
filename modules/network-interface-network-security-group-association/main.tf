resource "azurerm_network_interface_security_group_association" "this" {

  for_each = var.network_interface_network_security_group_associations

  network_interface_id = var.network_interfaces[each.value.network_interface_key].id

  network_security_group_id = var.network_security_groups[each.value.network_security_group_key].id

}