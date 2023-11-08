
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.52"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.3"
    }
  }
}


data "google_client_config" "default"{}

data "google_container_cluster" "my_cluster" {
  location = var.default_zone
  project = var.project_id
  name = "primary"
}
provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,)
}