terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.14"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.80.0"
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

provider "azurerm" {
  # Configuration options
}