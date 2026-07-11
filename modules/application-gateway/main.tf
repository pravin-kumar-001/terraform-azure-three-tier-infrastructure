resource "azurerm_application_gateway" "this" {

  for_each = var.application_gateways

  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name

  sku {

    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity

  }

  gateway_ip_configuration {

    name = "gateway-ip-configuration"

    subnet_id = var.subnets[each.value.subnet_key].id

  }

  frontend_ip_configuration {

    name = "frontend-ip-configuration"

    public_ip_address_id = var.public_ips[each.value.public_ip_key].id

  }

  frontend_port {

    name = "frontend-port"

    port = each.value.frontend_port

  }

  dynamic "backend_address_pool" {

    for_each = {

      default = each.value.backend_pool_name

    }

    content {

      name = backend_address_pool.value

      ip_addresses = [

        for vm_key in each.value.backend_vm_keys :

        var.linux_virtual_machines[vm_key].private_ip_address

      ]

    }

  }

  dynamic "backend_http_settings" {

    for_each = {

      default = each.value.backend_http_settings

    }

    content {

      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout

      probe_name = each.value.probe.name

    }

  }

  dynamic "probe" {

    for_each = {

      default = each.value.probe

    }

    content {

      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings

    }

  }

  dynamic "http_listener" {

    for_each = {

      default = each.value.listener

    }

    content {

      name = http_listener.value.name

      frontend_ip_configuration_name = "frontend-ip-configuration"

      frontend_port_name = "frontend-port"

      protocol = http_listener.value.protocol

    }

  }

  dynamic "request_routing_rule" {

    for_each = {

      default = each.value.request_routing_rule

    }

    content {

      name = request_routing_rule.value.name

      rule_type = request_routing_rule.value.rule_type

      priority = request_routing_rule.value.priority

      http_listener_name = each.value.listener.name

      backend_address_pool_name = each.value.backend_pool_name

      backend_http_settings_name = each.value.backend_http_settings.name

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

  depends_on = [

    var.public_ips,
    var.subnets,
    var.linux_virtual_machines

  ]

}