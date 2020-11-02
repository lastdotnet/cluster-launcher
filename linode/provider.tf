terraform {
  required_version = ">= 0.12.0"
}

provider "linode" {
  token = var.token
}
