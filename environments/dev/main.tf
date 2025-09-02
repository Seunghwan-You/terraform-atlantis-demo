terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "yooshwan-RG"            # 예: rg-terraform-state
    storage_account_name = "satfstatebrdc3iq1" # 예: satfstate12345678
    container_name       = "tfstate"
    key                  = "dev.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

locals {
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
}

module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
}

module "vm" {
  source              = "../../modules/vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  subnet_id           = module.networking.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

output "public_ip" {
  value = module.vm.public_ip
}


