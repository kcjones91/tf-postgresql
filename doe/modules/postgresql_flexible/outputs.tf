output "fqdn" {
  value = azurerm_postgresql_flexible_server.az_db.fqdn
}

output "admin_username" {
  value = azurerm_postgresql_flexible_server.az_db.administrator_login
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.az_db.id
}
