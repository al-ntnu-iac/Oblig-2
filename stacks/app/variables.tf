# tflint-ignore: terraform_unused_declarations
variable "kortnavn" {
  description = "Kortnavnet ditt. Settes i config/felles.tfvars."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.kortnavn))
    error_message = "kortnavn må være 2–10 små bokstaver eller tall. Sett det i config/felles.tfvars."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "location" {
  description = "Azure-regionen. Settes i config/felles.tfvars."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "miljo" {
  description = "Miljøet. Settes av scripts/kjor.sh (TF_VAR_miljo), ikke i en .tfvars-fil."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo må være dev eller prod."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "state_resource_group_name" {
  description = "Ressursgruppa til state-kontoen. Settes av scripts/kjor.sh fra shared/backend.hcl."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "state_storage_account_name" {
  description = "State-kontoen. Settes av scripts/kjor.sh fra shared/backend.hcl."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "state_container_name" {
  description = "Containeren state ligger i. Settes av scripts/kjor.sh fra shared/backend.hcl."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "tjenester" {
  description = "Tjenestene og kjøremiljøet deres: \"vm\" eller \"webapp\"."
  type        = map(string)

  validation {
    condition     = alltrue([for r in values(var.tjenester) : contains(["vm", "webapp"], r)])
    error_message = "Kjøremiljøet må være vm eller webapp."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "vm_size" {
  description = "VM-størrelsen for tjenester med runtime vm."
  type        = string
  default     = "Standard_B2als_v2"
}

# tflint-ignore: terraform_unused_declarations
variable "ssh_public_key" {
  description = "Offentlig SSH-nøkkel til VM-ene. Ikke hemmelig."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "webapp_sku" {
  description = "SKU for App Service-planene til tjenester med runtime webapp."
  type        = string
  default     = "P0v3"
}
