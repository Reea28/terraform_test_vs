output "vpc_id" {
  description = "ID of the VPC"
  value       = google_compute_network.gke-vpc.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = google_compute_subnetwork.private.id
}

output "vpc_name" {
  description = "ID of the VPC"
  value       = google_compute_network.gke-vpc.name
}

output "subnet_name" {
  description = "ID of the subnet"
  value       = google_compute_subnetwork.private.name
}