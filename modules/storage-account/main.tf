resource "azurerm_storage_account" "this" {

  for_each = var.storage_accounts

  name                     = each.value.name
  resource_group_name      = var.resource_groups[each.value.resource_group_key].name
  location                 = var.resource_groups[each.value.resource_group_key].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  tags = {

    Owner          = lookup(var.tags, "Owner", "")
    Project        = lookup(var.tags, "Project", "")
    Environment    = lookup(var.tags, "Environment", "")
    ManagedBy      = lookup(var.tags, "ManagedBy", "")
    CostCenter     = lookup(var.tags, "CostCenter", "")
    Department     = lookup(var.tags, "Department", "")
    CreatedBy      = lookup(var.tags, "CreatedBy", "")
    SubscriptionId = data.azurerm_client_config.current.subscription_id

  }

}