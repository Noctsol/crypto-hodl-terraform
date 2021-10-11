/*
Created Date - 2021-10-09
Summary:
  Controls resources for digital ocean

Links/Info
  Available DB slugs/skus: https://docs.digitalocean.com/reference/api/api-reference/#tag/Databases
  MONGODB DO INFO:         https://docs.digitalocean.com/products/databases/mongodb/
    - Version info
    - Regional availaility
  Terraform DO Docs:       https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
*/



# Creating a Project (think Resource Group/Subscription from Azure)
resource "digitalocean_project" "proj" {
  name        = "crypto-hodl"
  description = "Holds all the infrastructure resources for crypto-hodl to analyze crypto assets"
  purpose     = "Analytics"
  environment = "Production"

}

# Create a virtual private network
resource "digitalocean_vpc" "vpc" {
  name   = local.prod_vpc_name
  region = var.city_zone
}

# Generate Mongo DB Cluster
resource "digitalocean_database_cluster" "crypto_db" {
  name       = local.prod_db_name
  engine     = var.db_engine
  version    = var.mongo_version
  size       = var.db_sku
  region     = var.city_zone
  node_count = var.node_count
  private_network_uuid = digitalocean_vpc.vpc.id

  tags       = [
      var.project_name,
      var.env_type,
      var.db_engine,
      var.city_zone
  ]
}

# Generate DB within cluster
resource "digitalocean_database_db" "chdb" {
  cluster_id = digitalocean_database_cluster.crypto_db.id
  name       = var.project_name
}

# Generate service account user for db - unfortunately permission cannot be done here
resource "digitalocean_database_user" "svc" {
  cluster_id = digitalocean_database_cluster.crypto_db.id
  name       = var.mongodb_svc_user
}

# Add firewall rules to DB cluster to allow me to access
resource "digitalocean_database_firewall" "firewall" {
  cluster_id = digitalocean_database_cluster.crypto_db.id

  rule {
    type  = "ip_addr"
    value = var.my_ip
  }
}

# Add resource to proj
resource "digitalocean_project_resources" "proj_resources" {
  project = digitalocean_project.proj.id
  resources = [
    digitalocean_database_cluster.crypto_db.urn
  ]
}