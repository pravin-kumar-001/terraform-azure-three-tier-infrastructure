resource "azurerm_bastion_host" "this" {

  for_each = var.bastions

  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = var.resource_groups[each.value.resource_group_key].location
  sku                 = each.value.sku

  ip_configuration {

    name = "configuration"

    subnet_id = var.subnets[each.value.subnet_key].id

    public_ip_address_id = var.public_ips[each.value.public_ip_key].id

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