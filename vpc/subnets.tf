resource "google_compute_subnetwork" "private" {
  name = "private"
  ip_cidr_range = "10.0.0.0/18"
  region = var.region
  network = google_compute_network.gke-vpc.name
  private_ip_google_access = true
  project = var.project_id

  secondary_ip_range {
    range_name = var.gke-pod-range
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name = var.gke-service-range
    ip_cidr_range = "10.52.0.0/20"
  }

}