resource "google_sql_database" "database" {
  name     = "mysql-db"
  instance = google_sql_database_instance.instance.name
}
resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = var.db_pass
}
resource "google_compute_global_address" "private_ip_address" {
  #provider = google-beta
  project = var.project_id
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc-id
}
resource "google_service_networking_connection" "private_vpc_connection" {
  #provider = google-beta
  network                 = var.vpc-id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
resource "random_id" "db_name_suffix" {
  byte_length = 4
}
resource "google_sql_database_instance" "instance" {
  #provider = google-beta
  name             = "private-instance-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = var.database_version
    deletion_protection = false
  depends_on = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc-id
      enable_private_path_for_google_cloud_services = true
    }
  }
}