output "public_ips" {

  description = "Public IP Details"

  value = {

    for key, public_ip in azurerm_public_ip.this :

    key => {

      id         = public_ip.id
      name       = public_ip.name
      ip_address = public_ip.ip_address
      fqdn       = public_ip.fqdn

    }

  }

}