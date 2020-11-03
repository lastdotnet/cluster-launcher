provider "linode" {
  token = var.token
}

terraform {
  required_version = ">= 0.13"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.13.3"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 1.4.0"
    }
  }
}
