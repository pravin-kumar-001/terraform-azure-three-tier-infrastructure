resource "azurerm_subnet" "this" {

  for_each = local.subnets

  name = each.value.name

  resource_group_name = var.resource_groups[each.value.resource_group_key].name

  virtual_network_name = var.virtual_network_details[each.value.virtual_network_key].name

  address_prefixes = each.value.address_prefixes

}