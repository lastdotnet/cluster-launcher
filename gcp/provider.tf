terraform {
  required_version = ">= 0.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.62"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = local.region
}
