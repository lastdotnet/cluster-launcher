terraform {
  required_version = ">= 1.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.14"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1"
    }
  }
}

provider "digitalocean" {
  token = var.token
}
