resource "azurerm_network_interface" "this" {

  for_each = var.network_interfaces

  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name

  ip_configuration {

    name                          = each.value.ip_configuration.name
    subnet_id                     = var.subnets[each.value.subnet_key].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation

  }

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