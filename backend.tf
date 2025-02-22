
terraform {
  backend "azurerm" {
    resource_group_name  = "infratester-dev-tfstate"
    storage_account_name = "infratesterdevtfstate"
    container_name      = "tfstate"
    key                 = "terraform.tfstate"
  }
}