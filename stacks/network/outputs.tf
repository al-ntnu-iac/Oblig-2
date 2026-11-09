output "resource_group_name" {
  description = "Output for resource_group_name"
  value       = "rg-${var.kortnavn}-oblig2-${var.miljo}"
}

output "location" {
  description = "Output for location"
  value       = var.location
}

output "vnet_name" {
  description = "Output for vnet_name"
  value       = "vnet-${var.kortnavn}-${var.miljo}"
}

output "subnet_ids" {
  description = "Output for subnet_ids"
  value = {
    for navn, tjeneste in var.tjenester :
    navn => "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/rg-${var.kortnavn}-oblig2-${var.miljo}/providers/Microsoft.Network/virtualNetworks/vnet-${var.kortnavn}-${var.miljo}/subnets/snet-${navn}"
  }
}
