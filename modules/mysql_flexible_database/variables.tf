variable "mysql_flexible_servers" {

  description = "Map of Azure MySQL Flexible Servers"

  type = any

}

variable "resource_groups" {

  description = "Resource Group Details"

  type = any

}

variable "tags" {

  description = "Common Tags"

  type = map(string)

}