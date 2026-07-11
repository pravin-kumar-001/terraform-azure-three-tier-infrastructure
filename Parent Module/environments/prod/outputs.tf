output "resource_groups" {

  description = "Resource Group Details"

  value = module.resource_group.resource_groups

}

output "storage_accounts" {

  description = "Storage Account Details"

  value = module.storage_account.storage_accounts

}

output "virtual_networks" {

  description = "Virtual Network Details"

  value = module.virtual_network.virtual_networks

}

output "subnets" {

  description = "Subnet Details"

  value = module.subnet.subnets

}

output "network_security_groups" {

  description = "Network Security Group Details"

  value = module.network_security_group.network_security_groups

}

output "public_ips" {

  description = "Public IP Details"

  value = module.public_ip.public_ips

}

output "network_interfaces" {

  description = "Network Interface Details"

  value = module.network_interface.network_interfaces

}

output "network_interface_network_security_group_associations" {

  description = "NIC NSG Association Details"

  value = module.network_interface_network_security_group_association.network_interface_network_security_group_associations

}

output "linux_virtual_machines" {

  description = "Linux Virtual Machine Details"

  value = module.linux_virtual_machine.linux_virtual_machines

}

output "bastions" {

  description = "Azure Bastion Host Details"

  value = {

    for key, bastion in azurerm_bastion_host.this :

    key => {

      id   = bastion.id
      name = bastion.name
      dns_name = bastion.dns_name

    }

  }

}

output "application_gateways" {

  description = "Application Gateway Details"

  value = module.application_gateway.application_gateways

}

output "mysql_flexible_servers" {

  description = "Azure MySQL Flexible Server Details"

  value = module.mysql_flexible_server.mysql_flexible_servers

}