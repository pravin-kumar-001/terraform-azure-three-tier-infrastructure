output "network_security_groups" {

  description = "Network Security Group Details"

  value = {

    for key, network_security_group in azurerm_network_security_group.this :

    key => {

      id   = network_security_group.id
      name = network_security_group.name

    }

  }

}