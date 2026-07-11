output "virtual_networks" {

  description = "Virtual Network Details"

  value = {

    for key, virtual_network in azurerm_virtual_network.this :

    key => {

      id                  = virtual_network.id
      name                = virtual_network.name
      location            = virtual_network.location
      resource_group_name = virtual_network.resource_group_name

    }

  }

}