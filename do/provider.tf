terraform {
  required_version = ">= 0.12.0"
}

provider "digitalocean" {
  token = var.token
}
