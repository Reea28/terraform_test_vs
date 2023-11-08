
resource "google_container_cluster" "primary" {
  name     = "primary"
  location = var.default_zone #If we choose region we will have a high available cluster if we choose zone we will have a zonal cluster (one control plane node).
  #if we choose zonal cluster we should have more availability zones for kubernetes nodes.
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.subnet-name
  subnetwork               = var.vpc-name
  #the services will add costs
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes" #if we will have prometheus we can disable this
  project = var.project_id
  deletion_protection = false
  node_locations = [
    "us-central1-c"
  ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  release_channel {
    channel = "UNSPECIFIED"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pod-range"
    //services_secondary_range_name = "your-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }


}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
  project    = var.project_id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.primary.id
  project    = var.project_id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


