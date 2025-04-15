# Reference existing VNet
data "azurerm_virtual_network" "existing" {
  name                = var.existing_vnet_name
  resource_group_name = var.existing_vnet_resource_group_name
}

# Reference existing Subnet
data "azurerm_subnet" "existing" {
  name                 = var.existing_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = var.existing_vnet_resource_group_name
}

# Get current Azure client configuration
data "azurerm_client_config" "current" {}

# Validate Entra ID admin settings when using passwordAndManagedIdentity
locals {
  server_name         = "${var.postgres_server_name}-${var.environment}"
  entra_admin_required = var.authentication_method == "passwordAndManagedIdentity" && !var.entra_admin_enabled
  entra_admin_missing_info = var.entra_admin_enabled && (var.entra_admin_object_id == null || var.entra_admin_principal_name == null)
}

resource "null_resource" "validation_check" {
  count = local.entra_admin_required ? 1 : 0
  
  lifecycle {
    precondition {
      condition     = !local.entra_admin_required
      error_message = "When authentication_method is set to 'passwordAndManagedIdentity', entra_admin_enabled must be set to true."
    }
  }
}

resource "null_resource" "entra_admin_validation" {
  count = local.entra_admin_missing_info ? 1 : 0
  
  lifecycle {
    precondition {
      condition     = !local.entra_admin_missing_info
      error_message = "When entra_admin_enabled is true, you must provide values for entra_admin_object_id and entra_admin_principal_name."
    }
  }
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "this" {
  name                   = local.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password
  
  # Specify private access instead of public
  public_network_access_enabled = false
  
  storage_mb                   = var.postgres_storage_mb
  sku_name                     = var.postgres_sku
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  
  # High availability settings - only include if enabled
  dynamic "high_availability" {
    for_each = var.high_availability_enabled ? [1] : []
    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = var.availability_zone == null ? 2 : (var.availability_zone % 3) + 1
    }
  }
  
  # Availability zone
  zone = var.availability_zone
  
  # Authentication based on the chosen method
  authentication {
    active_directory_auth_enabled = var.authentication_method == "passwordAndManagedIdentity"
    password_auth_enabled         = true
  }
  
  # Tags
  tags = {
    environment   = var.environment
    workload_type = var.workload_type
  }
}

# Entra ID Administrator - Only create if enabled
resource "azurerm_postgresql_flexible_server_active_directory_administrator" "this" {
  count               = var.entra_admin_enabled ? 1 : 0
  server_name         = azurerm_postgresql_flexible_server.this.name
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = var.entra_admin_object_id
  principal_name      = var.entra_admin_principal_name
  principal_type      = var.entra_admin_principal_type
}

# Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink-${var.environment}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Link the DNS Zone to the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "postgres-dns-link-${var.environment}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = data.azurerm_virtual_network.existing.id
  registration_enabled  = false
}

# Private Endpoint for PostgreSQL
resource "azurerm_private_endpoint" "postgres" {
  name                = "pe-postgresql-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.existing.id

  private_service_connection {
    name                           = "psc-postgresql-${var.environment}"
    private_connection_resource_id = azurerm_postgresql_flexible_server.this.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = "postgres-dns-group-${var.environment}"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgres.id]
  }
}