terraform {
  required_version = ">= 0.14"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0.0"
    }
  }
}

provider "digitalocean" {
  token = var.token
}
