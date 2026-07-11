resource "azurerm_network_security_group" "this" {

  for_each = var.network_security_groups

  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = var.resource_groups[each.value.resource_group_key].location

  dynamic "security_rule" {

    for_each = each.value.security_rules

    content {

      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }

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