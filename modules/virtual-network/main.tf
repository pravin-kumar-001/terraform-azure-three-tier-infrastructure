resource "azurerm_virtual_network" "this" {

  for_each = var.virtual_networks

  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = var.resource_groups[each.value.resource_group_key].location
  address_space       = each.value.address_space

  tags = {

    Owner       = lookup(var.tags, "Owner", "")
    Project     = lookup(var.tags, "Project", "")
    Environment = lookup(var.tags, "Environment", "")
    ManagedBy   = lookup(var.tags, "ManagedBy", "")
    CostCenter  = lookup(var.tags, "CostCenter", "")
    Department  = lookup(var.tags, "Department", "")
    CreatedBy   = lookup(var.tags, "CreatedBy", "")

  }

}