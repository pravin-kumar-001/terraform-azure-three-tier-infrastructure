resource "azurerm_linux_virtual_machine" "this" {

  for_each = var.linux_virtual_machines

  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = var.resource_groups[each.value.resource_group_key].location

  size = each.value.size

  admin_username = each.value.admin_username

  disable_password_authentication = each.value.authentication_type == "ssh" ? true : false

  admin_password = each.value.authentication_type == "password" ? each.value.admin_password : null

  network_interface_ids = [

    var.network_interfaces[each.value.network_interface_key].id

  ]

  dynamic "admin_ssh_key" {

    for_each = each.value.authentication_type == "ssh" ? [1] : []

    content {

      username   = each.value.admin_username
      public_key = each.value.admin_ssh_key

    }

  }

  os_disk {

    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type

  }

  source_image_reference {

    publisher = each.value.image.publisher
    offer      = each.value.image.offer
    sku        = each.value.image.sku
    version    = each.value.image.version

  }

  identity {

    type = "SystemAssigned"

  }

  tags = {

    Owner       = lookup(var.tags, "Owner", "")
    Project     = lookup(var.tags, "Project", "")
    Environment = lookup(var.tags, "Environment", "")
    ManagedBy   = lookup(var.tags, "ManagedBy", "")
    CostCenter  = lookup(var.tags, "CostCenter", "")
    Department  = lookup(var.tags, "Department", "")
    CreatedBy   = lookup(var.tags, "CreatedBy", "")

    SubscriptionId = data.azurerm_client_config.this.subscription_id

  }

}