output "linux_virtual_machines" {

  value = {

    for key, vm in azurerm_linux_virtual_machine.this :

    key => {

      id                 = vm.id
      name               = vm.name
      private_ip_address = vm.private_ip_address

    }

  }

}