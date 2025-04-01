resource "random_string" "suffix" {
  length  = 5
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_postgresql_flexible_server" "az_db" {
  name                   = "${var.env}-pg-${random_string.suffix.result}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.db_admin
  administrator_password = var.db_password
  version                = "13"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  zone                   = "1"

  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = var.private_dns_zone_id

  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
}

resource "azurerm_postgresql_flexible_server_database" "example" {
  name      = "exampledb"
  server_id = azurerm_postgresql_flexible_server.az_db.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
