

hub_subscription_id   = "e4856824-3c90-41f7-9af3-cd62168c4d4e"
spoke_subscription_id = "1ebca6dc-4adb-4bd0-9460-6bd7dbaf2ce4"

hub_state_rg              = "terraformBackend-rg"
hub_state_storage_account = "terraforms23tatplatform"
hub_state_container       = "tfstate"
hub_state_key             = "prod-dev.tfstate"

hub_vnet_key = "mainvet"
hub_rg_key   = "rg1"

location        = "centralindia"
spoke_rg_name   = "rg-spoke-app1-prod-ci"
spoke_vnet_name = "vnet-spoke-app1-prod-ci"

spoke_address_space = ["10.20.0.0/16"]

spoke_subnets = {
  app = {
    name             = "snet-app"
    address_prefixes = ["10.20.1.0/24"]
  }

  db = {
    name             = "snet-db"
    address_prefixes = ["10.20.2.0/24"]
  }
}

tags = {
  Environment = "prod"
  Owner       = "Ajmer"
  ManagedBy   = "Terraform"
}