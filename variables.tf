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

variable "database_name" {
    type = string
    description  = "name of the database to create in the instance"
}
variable "db_user" {
    type = string
    description  = "user for the instance"
}
variable "db_pass" {
    type = string
    description  = "database user's password"
}
variable "database_version" {
    type = string
    default = "POSTGRES_13"
    description  = "type of database and version"
}
variable "tier" {
    type = string
    default = "db-f1-micro"
    description  = "machine type for the instance"
}