variable "network_security_groups" {

  description = "Map of Network Security Groups"

  type = map(object({

    name               = string
    resource_group_key = string

    security_rules = map(object({

      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))

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

variable "tags" {

  description = "Common Tags"

  type = map(string)

}