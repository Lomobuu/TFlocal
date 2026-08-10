locals {
  # ---------------------------------------------------------------------------
  # Naming standard (Azure CAF): <type-abbrev>-<workload>-<env>-<region>
  #
  #   rg-tflocal-test-noe
  #   kv-tflocal-test-noe
  #
  # Resource types that forbid dashes (ACR) drop them and concatenate instead:
  #
  #   acrtflocaltestnoe
  #
  # Every name is lowercase, and every name in this module comes from this
  # file. Do not inline a resource name in a .tf file.
  # ---------------------------------------------------------------------------

  # Workload token, shared by every resource name.
  base = "tflocal"

  # Short region code, derived from var.location so a name can never claim a
  # region the resource isn't actually in. Add entries as regions come into
  # use; an unmapped location fails the plan rather than producing a bad name.
  region_short = {
    norwayeast  = "noe"
    norwaywest  = "now"
    westeurope  = "weu"
    northeurope = "neu"
  }
  region = local.region_short[var.location]

  # The <workload>-<env>-<region> tail every name shares, in both the
  # dash-separated and dashless forms.
  suffix         = "${local.base}-${var.env}-${local.region}"
  suffix_compact = "${local.base}${var.env}${local.region}"

  # Resource names
  rg_name       = "rg-${local.suffix}"
  keyvault_name = "kv-${local.suffix}"
  cluster_name  = "aks-${local.suffix}"
  aca_env_name  = "cae-${local.suffix}"
  aca_app_name  = "ca-${local.suffix}"

  # ACR allows lowercase alphanumeric only — no dashes.
  acr_name         = "acr${local.suffix_compact}"
  acr_login_server = "${local.acr_name}.azurecr.io"

  # AKS DNS prefix: the dashless form is always a valid DNS label.
  aks_dns_prefix = local.suffix_compact
}
