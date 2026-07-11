output "subnets" {

  description = "Subnet Details"

  value = {

    for key, subnet in azurerm_subnet.this :

    key => {

      id = subnet.id

      name = subnet.name

    }

  }

}