terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.17.0"
    }
    random = {
      version = ">= 2.2.1"
    }
  }
}

# Configuration of Terraform with Azure environment variables
provider "azurerm" {
  features {
   resource_group {
     prevent_deletion_if_contains_resources = false
   }
  }
}
