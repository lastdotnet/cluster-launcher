terraform {
  required_version = ">= 0.14"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.13.4"
    }
  }
}

provider "linode" {
  token = var.token
}
