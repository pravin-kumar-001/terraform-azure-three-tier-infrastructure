locals {

  subnets = merge([

    for vnet_key, vnet in var.virtual_networks : {

      for subnet_key, subnet in vnet.subnets :

      "${vnet_key}-${subnet_key}" => {

        name               = subnet.name
        address_prefixes   = subnet.address_prefixes
        resource_group_key = vnet.resource_group_key
        virtual_network_key = vnet_key

      }

    }

  ]...)

}