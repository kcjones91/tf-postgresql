# Environment
environment = "dev"

# Resource Group and Location
resource_group_name = "test-rg"
location            = "West Europe" # Update to your preferred region

# PostgreSQL Server Configuration
postgres_server_name     = "psql-flex-server" # Update to your preferred name
postgres_admin_username  = "psqladmin"
postgres_admin_password  = "YourSecurePasswordHere" # Make sure to use a secure password
postgres_version         = "16"
postgres_sku             = "GP_Standard_D2s_v3"
postgres_storage_mb      = 32768

# Existing Network Resources
existing_vnet_resource_group_name = "test-rg"
existing_vnet_name                = "test-vnet"
existing_subnet_name              = "pg-subnet"

# High Availability and Backup Settings
high_availability_enabled    = false       # Set to true to enable high availability
backup_retention_days        = 7           # Between 7 and 35 days
geo_redundant_backup_enabled = false       # Set to true for geo-redundant backups
workload_type                = "Development" # Development or Production
availability_zone            = 1      # 1, 2, 3, or null to disable

# Authentication Settings
authentication_method = "passwordAndManagedIdentity" # "password" or "passwordAndManagedIdentity"

# Entra ID Administrator Settings
entra_admin_enabled         = true  # Set to true to configure an Entra ID admin
entra_admin_object_id       = "42d8eccf-9208-40ad-86dd-b7e634e35f76"   # Object ID of the Entra ID admin (required if enabled)
entra_admin_principal_name  = "rhlabs91_gmail.com#EXT#@rhlabs91gmail.onmicrosoft.com"   # Principal name of the Entra ID admin (required if enabled)
entra_admin_principal_type  = "User" # User, Group, or Application