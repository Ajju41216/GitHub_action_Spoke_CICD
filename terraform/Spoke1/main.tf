# data "terraform_remote_state" "hub" {
#   backend = "azurerm"

#   config = {
#     resource_group_name  = "terraformBackend-rg"
#     storage_account_name = "terraforms23tatplatform"
#     container_name       = "tfstate"
#     key                  = "prod-dev.tfstate"
#   }
# }

data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    subscription_id      = "e4856824-3c90-41f7-9af3-cd62168c4d4e"
    resource_group_name  = "terraformBackend-rg"
    storage_account_name = "terraforms23tatplatform"
    container_name       = "tfstate"
    key                  = "prod-dev.tfstate"

    use_oidc         = true
    use_azuread_auth = true
  }
}

resource "azurerm_resource_group" "spoke" {
  name     = var.spoke_rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = var.spoke_vnet_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = var.spoke_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "spoke" {
  for_each = var.spoke_subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-${azurerm_virtual_network.spoke.name}-to-hub"
  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = data.terraform_remote_state.hub.outputs.vnet_ids[var.hub_vnet_key]

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider = azurerm.hub

  name                      = "peer-hub-to-${azurerm_virtual_network.spoke.name}"
  resource_group_name       = data.terraform_remote_state.hub.outputs.rg_names[var.hub_rg_key]
  virtual_network_name      = data.terraform_remote_state.hub.outputs.vnet_names[var.hub_vnet_key]
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}