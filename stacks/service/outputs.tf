output "subnet_id" {
  description = "Subnett-ID for tjenesten."
  value       = module.subnet.subnet_id
}

output "storage_account_name" {
  description = "Storage Account for tjenesten."
  value       = module.storage.name
}

output "key_vault_name" {
  description = "Key Vault for tjenesten."
  value       = module.keyvault.name
}

output "vm_public_ip" {
  description = "Offentlig IP dersom tjenesten bruker VM."
  value       = var.runtime == "vm" ? module.vm[0].public_ip : null
}

output "webapp_hostname" {
  description = "Hostname dersom tjenesten bruker Web App."
  value       = var.runtime == "webapp" ? module.webapp[0].hostname : null
}
