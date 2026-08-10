variable "env" {
  type    = string
  default = "test"

  # Key Vault names cap at 24 characters and local.keyvault_name spends 15 of
  # them on the "kv-", workload, and region tokens, so env has 9 to work with.
  validation {
    condition     = can(regex("^[a-z0-9]{2,9}$", var.env))
    error_message = "env must be 2-9 lowercase alphanumeric characters (the 9-character cap keeps local.keyvault_name inside Key Vault's 24-character limit)."
  }
}

variable "location" {
  type    = string
  default = "norwayeast"

  # Must be a key in local.region_short, which supplies the region token in
  # every resource name.
  validation {
    condition     = contains(["norwayeast", "norwaywest", "westeurope", "northeurope"], var.location)
    error_message = "location must be one of: norwayeast, norwaywest, westeurope, northeurope. Add it to local.region_short and to this list to allow another region."
  }
}
