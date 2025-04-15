variable "environment" {
  description = "Environment (dev, prod, etc.)"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "postgres_server_name" {
  description = "Base name of the PostgreSQL Flexible Server (will be appended with environment)"
  type        = string
}

variable "postgres_admin_username" {
  description = "Administrator username for PostgreSQL server"
  type        = string
}

variable "postgres_admin_password" {
  description = "Administrator password for PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "16"
}

variable "postgres_sku" {
  description = "SKU name for the PostgreSQL server"
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "postgres_storage_mb" {
  description = "Storage size in MB"
  type        = number
  default     = 32768
}

variable "existing_vnet_resource_group_name" {
  description = "Resource group name of existing VNet"
  type        = string
}

variable "existing_vnet_name" {
  description = "Name of existing VNet"
  type        = string
}

variable "existing_subnet_name" {
  description = "Name of existing subnet for private endpoint"
  type        = string
}

variable "high_availability_enabled" {
  description = "Whether to enable high availability for the PostgreSQL server"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Backup retention days for the PostgreSQL server (between 7 and 35)"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "Backup retention days must be between 7 and 35."
  }
}

variable "geo_redundant_backup_enabled" {
  description = "Whether to enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "workload_type" {
  description = "Workload type of the PostgreSQL server (Development or Production)"
  type        = string
  default     = "Development"
  validation {
    condition     = contains(["Development", "Production"], var.workload_type)
    error_message = "Workload type must be either 'Development' or 'Production'."
  }
}

variable "availability_zone" {
  description = "Availability zone for the PostgreSQL server (1, 2, or 3)"
  type        = number
  default     = null
  validation {
    condition     = var.availability_zone == null || (var.availability_zone >= 1 && var.availability_zone <= 3)
    error_message = "Availability zone must be 1, 2, or 3, or null to disable."
  }
}

variable "authentication_method" {
  description = "Authentication method for the PostgreSQL server (password or passwordAndManagedIdentity)"
  type        = string
  default     = "password"
  validation {
    condition     = contains(["password", "passwordAndManagedIdentity"], var.authentication_method)
    error_message = "Authentication method must be either 'password' or 'passwordAndManagedIdentity'."
  }
}

variable "entra_admin_enabled" {
  description = "Whether to enable Entra ID administrator for the PostgreSQL server"
  type        = bool
  default     = false
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
  default     = "User"
  validation {
    condition     = contains(["User", "Group", "Application"], var.entra_admin_principal_type)
    error_message = "Principal type must be either 'User', 'Group', or 'Application'."
  }
}