output "storage_accounts" {

  description = "Storage Account Details"

  value = {

    for key, storage_account in azurerm_storage_account.this :

    key => {

      id                    = storage_account.id
      name                  = storage_account.name
      location              = storage_account.location
      primary_blob_endpoint = storage_account.primary_blob_endpoint

    }

  }

}