# Midlertidige outputs under migreringen.
# Ressursene flyttes til service-stackene.

output "storage_account_names" {
  value = tomap({})
}

output "key_vault_names" {
  value = tomap({})
}
