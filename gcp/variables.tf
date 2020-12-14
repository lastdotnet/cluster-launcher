variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "zone" {
  description = "GCP zone in region"
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
  default     = "1.17.14-gke.1200"
}

variable "nodes" {
  description = "GCP cluster node settings"
  type        = map(string)
  default = {
    preemptible      = false
    machine_type     = "n2d-standard-8" # 8CPU/32GB
    min_capacity     = 1
    max_capacity     = 10
    desired_capacity = 3
    disk_size        = 100
    disk_type        = "pd-standard"
  }
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["terraform", "thornode"]
}

locals {
  region = regex("(.*)(..$)", var.zone)[0]
}
