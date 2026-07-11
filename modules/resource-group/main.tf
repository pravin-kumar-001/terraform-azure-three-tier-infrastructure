resource "azurerm_resource_group" "this" {

  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location

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