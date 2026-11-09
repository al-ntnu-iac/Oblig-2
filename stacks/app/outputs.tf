# Midlertidige outputs under migreringen.
# VM og Web App flyttes til service-stackene.

output "vm_public_ips" {
  description = "Output for vm_public_ips"
  value       = tomap({})
}

output "webapp_hostnames" {
  description = "Output for webapp_hostnames"
  value       = tomap({})
}
