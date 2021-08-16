terraform {
  required_version = ">= 1.0"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.20"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1"
    }
  }
}

provider "linode" {
  token = var.token
}
