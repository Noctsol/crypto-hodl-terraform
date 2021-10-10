terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.14"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "quiavi"
    workspaces {
      name = "crypto-hodl-terraform"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}