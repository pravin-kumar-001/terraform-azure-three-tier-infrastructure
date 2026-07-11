module "resource_group" {

  source = "../../modules/resource-group"

  resource_groups = var.resource_groups
  tags            = var.tags

}

module "storage_account" {

  source = "../../modules/storage-account"

  storage_accounts = var.storage_accounts
  resource_groups  = module.resource_group.resource_groups
  tags             = var.tags

}

module "virtual_network" {

  source = "../../modules/virtual-network"

  virtual_networks = var.virtual_networks
  resource_groups  = module.resource_group.resource_groups
  tags             = var.tags

}

module "subnet" {

  source = "../../modules/subnet"

  virtual_networks = var.virtual_networks

  resource_groups = module.resource_group.resource_groups

  virtual_network_details = module.virtual_network.virtual_networks

}

module "network_security_group" {

  source = "../../modules/network-security-group"

  network_security_groups = var.network_security_groups
  resource_groups         = module.resource_group.resource_groups
  tags                    = var.tags

}

module "network_interface" {

  source = "../../modules/network-interface"

  network_interfaces = var.network_interfaces
  resource_groups    = module.resource_group.resource_groups
  subnets            = module.subnet.subnets
  tags               = var.tags

}

module "network_interface_network_security_group_association" {

  source = "../../modules/network-interface-network-security-group-association"

  network_interface_network_security_group_associations = var.network_interface_network_security_group_associations

  network_interfaces = module.network_interface.network_interfaces

  network_security_groups = module.network_security_group.network_security_groups

}

module "linux_virtual_machine" {

  source = "../../modules/linux-virtual-machine"

  linux_virtual_machines = var.linux_virtual_machines

  resource_groups = module.resource_group.resource_groups

  network_interfaces = module.network_interface.network_interfaces

  tags = var.tags

  depends_on = [

    module.network_interface_network_security_group_association

  ]

}

module "bastion" {

  source = "../../modules/bastion"

  bastions = var.bastions

  resource_groups = module.resource_group.resource_groups

  subnets = module.subnet.subnets

  public_ips = module.public_ip.public_ips

  tags = var.tags

  depends_on = [

    module.public_ip,
    module.subnet

  ]

}

module "application_gateway" {

  source = "../../modules/application-gateway"

  application_gateways = var.application_gateways

  resource_groups = module.resource_group.resource_groups

  subnets = module.subnet.subnets

  public_ips = module.public_ip.public_ips

  linux_virtual_machines = module.linux_virtual_machine.linux_virtual_machines

  tags = var.tags

  depends_on = [

    module.linux_virtual_machine,
    module.public_ip,
    module.subnet

  ]

}

module "mysql_flexible_server" {

  source = "../../modules/mysql-flexible-server"

  mysql_flexible_servers = var.mysql_flexible_servers

  resource_groups = module.resource_group.resource_groups

  tags = var.tags

  depends_on = [

    module.resource_group

  ]

}