output "resource_group_name" {
  description = "Output for resource_group_name"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Output for location"
  value       = azurerm_resource_group.this.location
}

output "vnet_name" {
  description = "Output for vnet_name"
  value       = module.vnet.name
}
