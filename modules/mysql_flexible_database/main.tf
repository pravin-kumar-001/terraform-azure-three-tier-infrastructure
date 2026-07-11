resource "azurerm_mysql_flexible_server" "this" {

  for_each = var.mysql_flexible_servers

  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = var.resource_groups[each.value.resource_group_key].location

  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password

  sku_name = each.value.sku_name

  version = each.value.version

  zone = each.value.zone

  backup_retention_days = each.value.backup.retention_days

  storage {

    size_gb = each.value.storage.size_gb

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

resource "azurerm_mysql_flexible_database" "this" {

  for_each = var.mysql_flexible_servers

  name = each.value.database.name

  resource_group_name = var.resource_groups[each.value.resource_group_key].name

  server_name = azurerm_mysql_flexible_server.this[each.key].name

  charset = each.value.database.charset

  collation = each.value.database.collation

}