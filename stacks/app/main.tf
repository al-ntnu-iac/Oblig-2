# Migrering fra gammel app-stack til service.
# Eksisterende Azure-ressurser beholdes.

removed {
  from = module.vm

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.webapp

  lifecycle {
    destroy = false
  }
}
