output "postgresql_server_fqdn" {
  value       = module.postgresql.postgresql_server_fqdn
  description = "The FQDN of the PostgreSQL Flexible Server"
}

output "postgresql_server_name" {
  value       = module.postgresql.postgresql_server_name
  description = "The name of the PostgreSQL Flexible Server"
}

output "private_endpoint_ip" {
  value       = module.postgresql.private_endpoint_ip
  description = "The private IP address of the PostgreSQL Private Endpoint"
}

output "resource_group_name" {
  value       = data.azurerm_resource_group.postgres.name
  description = "The name of the resource group containing PostgreSQL resources"
}