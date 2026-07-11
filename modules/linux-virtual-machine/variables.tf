variable "linux_virtual_machines" {

  description = "Map of Linux Virtual Machines"

  type = map(object({

    name               = string
    resource_group_key = string
    network_interface_key = string

    size = string

    admin_username = string

    authentication_type = string

    admin_password = optional(string)

    admin_ssh_key = optional(string)

    os_disk = object({

      caching              = string
      storage_account_type = string

    })

    image = object({

      publisher = string
      offer      = string
      sku        = string
      version    = string

    })

  }))

}

variable "resource_groups" {

  description = "Resource Group Details"

  type = any

}

variable "network_interfaces" {

  description = "Network Interface Details"

  type = any

}

variable "tags" {

  description = "Common Tags"

  type = map(string)

}