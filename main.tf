
# Creating a Project (think Resource Group/Subscription from Azure)
resource "digitalocean_project" "proj" {
  name        = "crypto-hodl"
  description = "Holds all the infrastructure resources for crypto-hodl to analyze crypto assets"
  purpose     = "Analytics"
  environment = "Production"
}

# Generate # DB
resource "digitalocean_database_cluster" "crypto_db" {
  name       = local.ch_db_name
  engine     = var.db_engine
  version    = "4.4"
  size       = "db-s-1vcpu-1gb"
  region     = var.city_zone
  node_count = 1
}

# Add resource to proj
resource "digitalocean_project_resources" "proj_resources" {
  project = digitalocean_project.proj.id
  resources = [
    digitalocean_database_cluster.crypto_db.urn
  ]
}