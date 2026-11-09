# Migrering fra gammel network-stack til shared-network og service.
# Ressursene beholdes i Azure og fjernes kun fra gammel Terraform state.

removed {
  from = azurerm_resource_group.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.vnet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.subnet

  lifecycle {
    destroy = false
  }
}

data "azurerm_client_config" "current" {}
