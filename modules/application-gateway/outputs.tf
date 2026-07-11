output "application_gateways" {

  description = "Application Gateway Details"

  value = {

    for key, application_gateway in azurerm_application_gateway.this :

    key => {

      id = application_gateway.id

      name = application_gateway.name

      frontend_public_ip_id = application_gateway.frontend_ip_configuration[0].public_ip_address_id

      backend_address_pool_id = application_gateway.backend_address_pool[0].id

      frontend_port = application_gateway.frontend_port[0].port

    }

  }

}