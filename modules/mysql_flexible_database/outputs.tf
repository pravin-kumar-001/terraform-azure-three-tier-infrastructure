output "mysql_flexible_servers" {

  description = "Azure MySQL Flexible Server Details"

  value = {

    for key, server in azurerm_mysql_flexible_server.this :

    key => {

      id   = server.id
      name = server.name
      fqdn = server.fqdn

    }

  }

}