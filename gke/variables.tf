variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "gke-pod-range" {
  type = string
  default = "10.48.0.0/14"
}

variable "gke-service-range" {
  type = string
}

variable "default_zone" {
  type = string
}

variable "prefix_length" {
  type = number
  default = 16
}

variable "vpc-name" {
  type = string
}

variable "subnet-name" {
  type = string
}

variable "roles" {
  type = list(string)
  default = [ 
    "roles/artifactregistry.reader",
    "roles/storage.objectViewer",
    "roles/servicemanagement.serviceController",
    "roles/logging.logWriter",
    "roles/monitoring.admin",
    "roles/cloudtrace.agent"
  ]
  description = "list of roles for the node pool service account."
  
}