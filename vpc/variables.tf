variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "gke-pod-range" {
  type = string
  default = "gke-pod-range"
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

