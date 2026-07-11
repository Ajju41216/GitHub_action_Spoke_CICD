output "vnet_names" {
  value = {
    for k, v in azurerm_virtual_network.vnet :
    k => v.name
  }
}

output "vnet_ids" {
  value = {
    for k, v in azurerm_virtual_network.vnet :
    k => v.id
  }
}