variable "bastions" {

  description = "Map of Azure Bastion Hosts"

  type = map(object({

    name               = string
    resource_group_key = string
    subnet_key         = string
    public_ip_key      = string
    sku                = string

  }))

}

variable "resource_groups" {

  type = map(object({

    id       = string
    name     = string
    location = string

  }))

}

variable "subnets" {

  type = map(object({

    id   = string
    name = string

  }))

}

variable "public_ips" {

  type = any

}

variable "tags" {

  type = map(string)

}