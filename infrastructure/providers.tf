# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm"{
    resource_group_name  = "management"
    storage_account_name = "stmanagementstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
//  backend "local" {
//    path = "terraform.tfstate"
//  }
}