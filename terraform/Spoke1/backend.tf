# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraformBackend-rg"
#     storage_account_name = "terraforms23tatplatform" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
#     container_name       = "tfstate"                 # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
#     key                  = "app1-dev.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
#   }
# }

terraform {
  backend "azurerm" {
    subscription_id      = "e4856824-3c90-41f7-9af3-cd62168c4d4e"
    resource_group_name  = "terraformBackend-rg"
    storage_account_name = "terraforms23tatplatform"
    container_name       = "tfstate"
    key                  = "spoke.tfstate"

    use_oidc            = true
    use_azuread_auth    = true
  }
}