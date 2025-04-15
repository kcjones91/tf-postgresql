output "postgresql_server_fqdn" {
  value       = azurerm_postgresql_flexible_server.this.fqdn
  description = "The FQDN of the PostgreSQL Flexible Server"
}

output "postgresql_server_id" {
  value       = azurerm_postgresql_flexible_server.this.id
  description = "The ID of the PostgreSQL Flexible Server"
}

output "postgresql_server_name" {
  value       = azurerm_postgresql_flexible_server.this.name
  description = "The name of the PostgreSQL Flexible Server"
}

output "private_endpoint_ip" {
  value       = azurerm_private_endpoint.postgres.private_service_connection[0].private_ip_address
  description = "The private IP address of the PostgreSQL Private Endpoint"
}

output "dns_zone_id" {
  value       = azurerm_private_dns_zone.postgres.id
  description = "The ID of the Private DNS Zone for PostgreSQL"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "The name of the resource group containing PostgreSQL resources"
}

output "environment" {
  value       = var.environment
  description = "The environment name"
}