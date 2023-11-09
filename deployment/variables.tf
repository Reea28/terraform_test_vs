variable "project_id" {
  type = string
}
variable "region" {
  type = string
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
    description  = "machine type for the instance"
}
variable "vpc-id" {
    type = string
    description  = "The id of the vpc resource"
}

variable "default_zone" {
  type = string
}

# variable "tls_crt" {
#   type = string
#   description = "tls certificate"
# }

# variable "tls_key" {
#   type = string
#   description = "tls key"
# }

# variable "api_key" {
#   type        = string
#   description = "credentials for accessing the iex api"
# }