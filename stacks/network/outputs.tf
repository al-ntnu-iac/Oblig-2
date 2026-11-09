output "resource_group_name" {
  value = "rg-${var.kortnavn}-oblig2-${var.miljo}"
}

output "location" {
  value = var.location
}

output "vnet_name" {
  value = "vnet-${var.kortnavn}-${var.miljo}"
}

output "subnet_ids" {
  value = {
    for navn, tjeneste in var.tjenester :
    navn => "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/rg-${var.kortnavn}-oblig2-${var.miljo}/providers/Microsoft.Network/virtualNetworks/vnet-${var.kortnavn}-${var.miljo}/subnets/snet-${navn}"
  }
}
