output "resource_groups" {

  description = "Resource Group Details"

  value = {

    for key, resource_group in azurerm_resource_group.this :

    key => {

      id       = resource_group.id
      name     = resource_group.name
      location = resource_group.location

    }

  }

}