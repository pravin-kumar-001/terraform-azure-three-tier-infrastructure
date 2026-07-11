variable "network_interfaces" {

  description = "Map of Network Interfaces"

  type = map(object({

    name               = string
    resource_group_key = string
    subnet_key         = string

    ip_configuration = object({

      name                          = string
      private_ip_address_allocation = string

    })

  }))

}

variable "resource_groups" {

  description = "Resource Group Details"

  type = any

}

variable "subnets" {

  description = "Subnet Details"

  type = any

}

variable "tags" {

  description = "Common Tags"

  type = map(string)

}