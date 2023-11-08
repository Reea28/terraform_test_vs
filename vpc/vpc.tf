resource "google_compute_network" "gke-vpc" {
  name = "gke-vpc"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  project = var.project_id
}

