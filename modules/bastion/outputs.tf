output "linux_virtual_machines" {

  description = "Linux Virtual Machine Details"

  value = {

    for key, virtual_machine in azurerm_linux_virtual_machine.this :

    key => {

      id                  = virtual_machine.id
      name                = virtual_machine.name
      location            = virtual_machine.location
      private_ip_address  = virtual_machine.private_ip_address
      virtual_machine_id  = virtual_machine.virtual_machine_id
      identity_principal_id = virtual_machine.identity[0].principal_id

    }

  }

}