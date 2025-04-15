PostgreSQL Flexible Server with Terraform
This repository contains Terraform configurations for deploying Azure PostgreSQL Flexible Server in multiple environments using a modular approach.
Structure
terraform-postgresql/
├── environments/
│   ├── dev/           # Development environment configuration
│   └── prod/          # Production environment configuration
├── modules/
│   └── postgresql-flexible/  # Reusable PostgreSQL module
└── README.md
Prerequisites

Terraform v1.0.0 or newer
Azure CLI installed and authenticated
Existing virtual network and subnet for the private endpoint

Module: postgresql-flexible
This module deploys:

Azure PostgreSQL Flexible Server
Private Endpoint for secure connectivity
Private DNS Zone for PostgreSQL
Entra ID Administrator (optional)

The module supports various configuration options including:

High availability
Backup retention and geo-redundancy
Authentication methods
Workload types

Environment-Specific Configurations
Development Environment
The development environment (environments/dev/) uses:

Smaller SKU (GP_Standard_D2s_v3)
Limited storage (32GB)
No high availability
Minimal backup retention (7 days)
Simple password authentication
Development workload type

Production Environment
The production environment (environments/prod/) uses:

Larger SKU (GP_Standard_D4s_v3)
More storage (64GB)
High availability enabled
Extended backup retention (30 days) with geo-redundancy
Both password and Entra ID authentication
Production workload type
Entra ID group-based administration

Deployment Instructions
1. Prepare Variables
For each environment:

Edit the corresponding terraform.tfvars file
Set the appropriate values for your environment
Update the PostgreSQL admin password with a secure value
For production, provide valid Entra ID group details

2. Deploy Development Environment
bashcd environments/dev
terraform init
terraform plan -out=dev.tfplan
terraform apply dev.tfplan
3. Deploy Production Environment
bashcd environments/prod
terraform init
terraform plan -out=prod.tfplan
terraform apply prod.tfplan
State Management
For production use, configure a remote backend (Azure Storage) by uncommenting and configuring the backend block in each environment's main.tf.
Security Considerations

Store sensitive values (passwords, etc.) in Azure Key Vault or environment variables
Use a secure method to manage and inject the PostgreSQL admin password
Ensure proper networking configuration for private endpoints
Review IAM permissions for the Entra ID administrator group

Customization
Each environment's configuration can be further customized by adjusting:

Virtual network and subnet settings
Region/location
Server SKUs
Authentication methods
Backup policies

Outputs
Each environment exports the following outputs:

PostgreSQL server FQDN
PostgreSQL server name
Private Endpoint IP address
Resource Group name