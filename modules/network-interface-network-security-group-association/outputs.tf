output "network_interface_network_security_group_associations" {

  description = "NIC NSG Association Details"

  value = {

    for key, association in azurerm_network_interface_security_group_association.this :

    key => {

      id = association.id

    }

  }

}