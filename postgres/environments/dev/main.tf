terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Uncomment this block to use a remote backend (like Azure Storage)
  # backend "azurerm" {
  #   resource_group_name  = "tfstate"
  #   storage_account_name = "tfstate01234"
  #   container_name       = "tfstate"
  #   key                  = "dev.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "3627889f-c86b-438f-a13d-8c23ed294589"
}

# Reference existing Resource Group
data "azurerm_resource_group" "postgres" {
  name = var.resource_group_name
}

# Use the PostgreSQL Flexible Server module
module "postgresql" {
  source = "../../modules/postgresql-flexible"
  
  # Environment
  environment = var.environment
  
  # Resource group and location
  resource_group_name = data.azurerm_resource_group.postgres.name
  location            = data.azurerm_resource_group.postgres.location
  
  # PostgreSQL configuration
  postgres_server_name     = var.postgres_server_name
  postgres_admin_username  = var.postgres_admin_username
  postgres_admin_password  = var.postgres_admin_password
  postgres_version         = var.postgres_version
  postgres_sku             = var.postgres_sku
  postgres_storage_mb      = var.postgres_storage_mb
  
  # Network configuration
  existing_vnet_resource_group_name = var.existing_vnet_resource_group_name
  existing_vnet_name                = var.existing_vnet_name
  existing_subnet_name              = var.existing_subnet_name
  
  # High availability and backup settings
  high_availability_enabled    = var.high_availability_enabled
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  workload_type                = var.workload_type
  availability_zone            = var.availability_zone
  
  # Authentication settings
  authentication_method       = var.authentication_method
  entra_admin_enabled         = var.entra_admin_enabled
  entra_admin_object_id       = var.entra_admin_object_id
  entra_admin_principal_name  = var.entra_admin_principal_name
  entra_admin_principal_type  = var.entra_admin_principal_type
}