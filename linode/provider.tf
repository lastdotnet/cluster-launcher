terraform {
  required_version = ">= 0.14"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.14"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}

provider "linode" {
  token = var.token
}
