variable "public_ips" {

  description = "Map of Public IP Addresses"

  type = map(object({

    name               = string
    resource_group_key = string
    allocation_method  = string
    sku                = string

  }))

}

variable "resource_groups" {

  description = "Resource Group Details"

  type = any

}

variable "tags" {

  description = "Common Tags"

  type = map(string)

}