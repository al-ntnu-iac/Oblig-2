# Migrering fra gammel data-stack til service.
# Ressursene beholdes i Azure.

removed {
  from = module.storage

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.keyvault

  lifecycle {
    destroy = false
  }
}
