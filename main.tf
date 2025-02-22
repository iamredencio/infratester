
# Configure Azure Provider
provider "azurerm" {
  features {}
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "infratester-dev-rg"
  location = "westus"
  
  tags = {
    Environment = "dev"
    Project     = "infratester"
  }
}
# Create Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "infratesterdevsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind            = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version         = "TLS1_2"
  
  is_hns_enabled = true
  
  blob_properties {
    versioning_enabled = false
    
  }

  tags = {
    Environment = "dev"
    Project     = "infratester"
  }
}
# Create Blob Container
resource "azurerm_storage_container" "blob" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
# Create Power BI Embedded
resource "azurerm_powerbi_embedded" "pbi" {
  name                = "infratester-dev-pbi"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "A1"
  administrators      = [""]

  tags = {
    Environment = "dev"
    Project     = "infratester"
  }
}