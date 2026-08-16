locals {
  tags = merge({
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "terraform-cicd-github-actions"
  }, var.tags)
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.prefix}-${var.environment}-cicd"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "this" {
  name                     = "st${var.prefix}${var.environment}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_properties {
    versioning_enabled = true
  }

  tags = local.tags
}
