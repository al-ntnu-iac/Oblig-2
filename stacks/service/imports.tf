# Import av eksisterende ressurser til tjenestestacken.
# ID-ene bygges dynamisk uten hardkodet abonnement.

locals {
  import_rg = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.network.resource_group_name}"

  import_network = "${local.import_rg}/providers/Microsoft.Network"
  import_subnet  = "${local.import_network}/virtualNetworks/${local.network.vnet_name}/subnets/snet-${var.service}"
  import_nsg     = "${local.import_network}/networkSecurityGroups/nsg-${var.service}"

  import_resources = {
    subnet   = local.import_subnet
    nsg      = local.import_nsg
    rule     = "${local.import_nsg}/securityRules/allow-http"
    storage  = "${local.import_rg}/providers/Microsoft.Storage/storageAccounts/st${var.kortnavn}${var.service}${var.miljo}"
    keyvault = "${local.import_rg}/providers/Microsoft.KeyVault/vaults/kv-${var.kortnavn}-${var.service}-${var.miljo}"
  }
}

import {
  for_each = { for k, v in local.import_resources : k => v if k == "subnet" }
  to       = module.subnet.azurerm_subnet.this
  id       = each.value
}

import {
  for_each = { for k, v in local.import_resources : k => v if k == "nsg" }
  to       = module.subnet.azurerm_network_security_group.this
  id       = each.value
}

import {
  for_each = { for k, v in local.import_resources : k => v if k == "rule" }
  to       = module.subnet.azurerm_network_security_rule.http
  id       = each.value
}

import {
  for_each = { for k, v in local.import_resources : k => v if k == "storage" }
  to       = module.storage.azurerm_storage_account.this
  id       = each.value
}

import {
  for_each = { for k, v in local.import_resources : k => v if k == "keyvault" }
  to       = module.keyvault.azurerm_key_vault.this
  id       = each.value
}

# Tilknytning mellom subnett og NSG.
import {
  for_each = { association = local.import_subnet }
  to       = module.subnet.azurerm_subnet_network_security_group_association.this
  id       = each.value
}

# Ressurser for VM-tjenester.
import {
  for_each = var.runtime == "vm" ? { vm = "${local.import_rg}/providers/Microsoft.Compute/virtualMachines/vm-${var.service}" } : {}
  to       = module.vm[0].azurerm_linux_virtual_machine.this
  id       = each.value
}

import {
  for_each = var.runtime == "vm" ? { nic = "${local.import_network}/networkInterfaces/nic-${var.service}" } : {}
  to       = module.vm[0].azurerm_network_interface.this
  id       = each.value
}

import {
  for_each = var.runtime == "vm" ? { pip = "${local.import_network}/publicIPAddresses/pip-${var.service}" } : {}
  to       = module.vm[0].azurerm_public_ip.this
  id       = each.value
}

# Ressurser for Web App-tjenester.
import {
  for_each = var.runtime == "webapp" ? { app = "${local.import_rg}/providers/Microsoft.Web/sites/app-${var.kortnavn}-${var.service}-${var.miljo}" } : {}
  to       = module.webapp[0].azurerm_linux_web_app.this
  id       = each.value
}

import {
  for_each = var.runtime == "webapp" ? { plan = "${local.import_rg}/providers/Microsoft.Web/serverFarms/asp-${var.service}" } : {}
  to       = module.webapp[0].azurerm_service_plan.this
  id       = each.value
}
