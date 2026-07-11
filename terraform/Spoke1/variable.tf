variable "hub_subscription_id" {}
variable "spoke_subscription_id" {}

variable "hub_state_rg" {}
variable "hub_state_storage_account" {}
variable "hub_state_container" {}
variable "hub_state_key" {}

variable "hub_vnet_key" {
  default = "hub"
}

variable "hub_rg_key" {
  default = "hub"
}

variable "location" {
  default = "centralindia"
}

variable "spoke_rg_name" {}
variable "spoke_vnet_name" {}

variable "spoke_address_space" {
  type = list(string)
}

variable "spoke_subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}