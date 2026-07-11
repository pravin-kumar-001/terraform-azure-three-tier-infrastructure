variable "application_gateways" {

  description = "Map of Application Gateways"

  type = map(object({

    name               = string
    resource_group_key = string

    subnet_key = string

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

variable "resource_groups" {

  description = "Resource Group Details"

  type = map(object({

    id       = string
    name     = string
    location = string

  }))

}

variable "subnets" {

  description = "Subnet Details"

  type = map(object({

    id   = string
    name = string

  }))

}

variable "public_ips" {

  description = "Public IP Details"

  type = map(object({

    id         = string
    name       = string
    ip_address = string
    fqdn       = string

  }))

}

variable "linux_virtual_machines" {

  description = "Linux Virtual Machine Details"

  type = map(object({

    id                 = string
    name               = string
    private_ip_address = string

  }))

}

variable "tags" {

  description = "Common Resource Tags"

  type = map(string)

}