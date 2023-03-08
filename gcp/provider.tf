terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.52"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = local.region
}
