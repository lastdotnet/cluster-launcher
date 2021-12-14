variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
  type        = string
}

variable "network" {
  description = "Network settings"
  type        = map(string)
  default = {
    nodes    = "10.0.0.0/24"
    pods     = "10.1.0.0/16"
    services = "10.2.0.0/16"
  }
}

variable "kubernetes_version" {
  description = "GKE kubernetes version"
  type        = string
  default     = "1.20" # Auto upgrade to latest patch version
}

variable "nodes" {
  description = "GCP cluster node settings"
  type        = map(string)
  default = {
    preemptible      = false
    machine_type     = "n2d-standard-8" # 8CPU/32GB
    min_capacity     = 1
    max_capacity     = 4
    desired_capacity = 3
    disk_size        = 100
    disk_type        = "pd-ssd"
  }
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["terraform", "thornode"]
}

locals {
  is_zonal = length(regexall("-", var.location)) == 2
  region   = local.is_zonal ? regex("(.*)(..$)", var.location)[0] : var.location
}
