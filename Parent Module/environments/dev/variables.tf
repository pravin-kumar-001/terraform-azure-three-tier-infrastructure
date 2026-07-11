variable "resource_groups" {
  description = "Resource Group Configuration"
  type = any
}

variable "tags" {
  description = "Common Tags"
  type = any

}

variable "storage_accounts" {

  description = "Map of Storage Accounts"

  type = any

}

variable "virtual_networks" {

  description = "Map of Virtual Networks"

  type = map(object({

    name               = string
    resource_group_key = string
    address_space      = list(string)

    subnets = map(object({

      name             = string
      address_prefixes = list(string)

    }))

  }))

}

variable "network_security_groups" {

  description = "Map of Network Security Groups"

  type = any

}

variable "public_ips" {

  description = "Map of Public IP Addresses"

  type = any

}

variable "network_interfaces" {

  description = "Map of Network Interfaces"

  type = any

}

variable "network_interface_network_security_group_associations" {

  description = "Map of NIC NSG Associations"

  type = any

}

variable "linux_virtual_machines" {

  description = "Map of Linux Virtual Machines"

  type = any

}

variable "bastions" {

  description = "Map of Azure Bastion Hosts"

  type = any

}

variable "application_gateways" {

  description = "Map of Application Gateways"

  type = map(object({

    name               = string
    resource_group_key = string

    subnet_key    = string
    public_ip_key = string

    backend_vm_keys = list(string)

    sku = object({

      name     = string
      tier     = string
      capacity = number

    })

    frontend_port = number

    backend_pool_name = string

    backend_http_settings = object({

      name                  = string
      port                  = number
      protocol              = string
      cookie_based_affinity = string
      request_timeout       = number

    })

    probe = object({

      name                                      = string
      protocol                                  = string
      path                                      = string
      interval                                  = number
      timeout                                   = number
      unhealthy_threshold                       = number
      pick_host_name_from_backend_http_settings = bool

    })

    listener = object({

      name     = string
      protocol = string

    })

    request_routing_rule = object({

      name      = string
      rule_type = string
      priority  = number

    })

  }))

}

variable "mysql_flexible_servers" {

  description = "Map of Azure MySQL Flexible Servers"

  type = any

}