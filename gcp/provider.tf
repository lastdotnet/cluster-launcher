terraform {
  required_version = ">= 0.15"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.71"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = local.region
}
