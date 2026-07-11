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