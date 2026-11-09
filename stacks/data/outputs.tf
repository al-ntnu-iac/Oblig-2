# Midlertidige outputs under migreringen.
# Ressursene flyttes til service-stackene.

output "storage_account_names" {
  description = "Output for storage_account_names"
  value       = tomap({})
}

output "key_vault_names" {
  description = "Output for key_vault_names"
  value       = tomap({})
}
