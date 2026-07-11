
# Fetch the existing Hub Virtual Network details
data "azurerm_virtual_network" "hub" {
  name                = "HubVNet"
  resource_group_name = "hub-rg-network"
}

# Fetch the newly created Spoke Virtual Network details
data "azurerm_virtual_network" "spoke" {
  name                = "spokevnet"
  resource_group_name = "spoke-rg"
}



data "azurerm_virtual_network" "hub" {
  provider            = azurerm.hub
  name                = "vnet-hub"
  resource_group_name = "rg-hub-networking"
}