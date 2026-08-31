# db.tf
resource "mysql_user" "app_user" {
  user               = "app_service"
  host               = "%"

  database_password = "password123!"
}
