
provider "google" {
  project = var.project_id
  region  = var.region
}
terraform {
  backend "gcs" {
    bucket = "test-bucket-unique-nour-andreea-sign"
    prefix = "terraform/state"
  }
}


module "vpc" {
  source            = "./vpc"
  project_id        = var.project_id
  region            = var.region
  gke-service-range = var.gke-service-range
  default_zone      = var.default_zone
}

module "gke" {
  source            = "./gke"
  project_id        = var.project_id
  region            = var.region
  gke-service-range = var.gke-service-range
  default_zone      = var.default_zone
  vpc-name          = module.vpc.subnet_name
  subnet-name       = module.vpc.vpc_name
}

module "sql" {
  source = "./sql"
  project_id = var.project_id
  region = var.region
  database_version = var.database_version
  tier = var.tier
  database_name = var.database_name
  db_pass = var.db_pass
  db_user = var.db_user
  vpc-id = module.vpc.vpc_id
}

# module "deployment" {
#   source            = "./deployment"
#   project_id        = var.project_id
#   region            = var.region
#   default_zone      = var.default_zone
#     database_version = var.database_version
#   tier = var.tier
#   database_name = var.database_name
#   db_pass = var.db_pass
#   db_user = var.db_user
#   vpc-id = module.vpc.vpc_id
#}





