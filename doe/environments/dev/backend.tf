terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "govterraformstate"
    container_name       = "tfstate"
    key                  = "dev-db.tfstate"
  }
}
