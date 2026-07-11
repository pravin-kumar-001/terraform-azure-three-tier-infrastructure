output "network_interfaces" {

  description = "Network Interface Details"

  value = {

    for key, network_interface in azurerm_network_interface.this :

    key => {

      id   = network_interface.id
      name = network_interface.name

    }

  }

}