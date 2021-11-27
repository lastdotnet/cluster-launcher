terraform {
  required_version = ">= 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.32"
    }
  }
}

provider "hcloud" {
  token = var.token
}
