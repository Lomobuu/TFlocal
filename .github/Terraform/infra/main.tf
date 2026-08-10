terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.68.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-tflocal-Management-weu"
    storage_account_name = "satflocalmanagementweu"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }

}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }


    key_vault {
      purge_soft_delete_on_destroy = false
    }


  }
  use_oidc = true
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}