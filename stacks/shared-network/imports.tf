# Import av eksisterende nettverksressurser.
# Subscription ID hentes dynamisk fra Azure.

data "azurerm_client_config" "current" {}

locals {
  subscription_id   = data.azurerm_client_config.current.subscription_id
  resource_group_id = "/subscriptions/${local.subscription_id}/resourceGroups/rg-${var.kortnavn}-oblig2-${var.miljo}"
  vnet_id           = "${local.resource_group_id}/providers/Microsoft.Network/virtualNetworks/vnet-${var.kortnavn}-${var.miljo}"
}

import {
  for_each = { rg = local.resource_group_id }
  to       = azurerm_resource_group.this
  id       = each.value
}

import {
  for_each = { vnet = local.vnet_id }
  to       = module.vnet.azurerm_virtual_network.this
  id       = each.value
}
