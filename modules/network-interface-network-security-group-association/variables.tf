variable "network_interface_network_security_group_associations" {

  description = "Map of NIC NSG Associations"

  type = map(object({

    network_interface_key      = string
    network_security_group_key = string

  }))

}

variable "network_interfaces" {

  description = "Network Interface Details"

  type = map(object({

    id   = string
    name = string

  }))

}

variable "network_security_groups" {

  description = "Network Security Group Details"

  type = map(object({

    id   = string
    name = string

  }))

}