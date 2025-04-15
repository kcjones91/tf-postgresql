variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-postgresql-prod"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "postgres_server_name" {
  description = "Base name of the PostgreSQL Flexible Server (will be appended with environment)"
  type        = string
  default     = "psql-flex"
}

variable "postgres_admin_username" {
  description = "Administrator username for PostgreSQL server"
  type        = string
  default     = "psqladmin"
}

variable "postgres_admin_password" {
  description = "Administrator password for PostgreSQL server"
  type        = string
  sensitive   = true
  # No default for sensitive values
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "16"
}

variable "postgres_sku" {
  description = "SKU name for the PostgreSQL server"
  type        = string
  default     = "GP_Standard_D4s_v3"
}

variable "postgres_storage_mb" {
  description = "Storage size in MB"
  type        = number
  default     = 65536
}

variable "existing_vnet_resource_group_name" {
  description = "Resource group name of existing VNet"
  type        = string
  default     = "test-rg"
}

variable "existing_vnet_name" {
  description = "Name of existing VNet"
  type        = string
  default     = "test-vnet"
}

variable "existing_subnet_name" {
  description = "Name of existing subnet for private endpoint"
  type        = string
  default     = "pg-subnet"
}

variable "high_availability_enabled" {
  description = "Whether to enable high availability for the PostgreSQL server"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Backup retention days for the PostgreSQL server (between 7 and 35)"
  type        = number
  default     = 30
}

variable "geo_redundant_backup_enabled" {
  description = "Whether to enable geo-redundant backups"
  type        = bool
  default     = true
}

variable "workload_type" {
  description = "Workload type of the PostgreSQL server (Development or Production)"
  type        = string
  default     = "Production"
}

variable "availability_zone" {
  description = "Availability zone for the PostgreSQL server (1, 2, or 3)"
  type        = number
  default     = 1
}

variable "authentication_method" {
  description = "Authentication method for the PostgreSQL server (password or passwordAndManagedIdentity)"
  type        = string
  default     = "passwordAndManagedIdentity"
}

variable "entra_admin_enabled" {
  description = "Whether to enable Entra ID administrator for the PostgreSQL server"
  type        = bool
  default     = true
}

variable "entra_admin_object_id" {
  description = "Object ID of the Entra ID administrator"
  type        = string
  default     = null
}

variable "entra_admin_principal_name" {
  description = "Principal name of the Entra ID administrator"
  type        = string
  default     = null
}

variable "entra_admin_principal_type" {
  description = "Principal type of the Entra ID administrator (User, Group, Application)"
  type        = string
  default     = "Group"
}