variable "name" {
  description = "The base name used for all resources"
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created"
  type        = string
}

variable "node_pool_settings" {
  description = "Cluster node pool settings"
  type        = map(string)
  default = {
    desired_capacity = 3
    max_capacity     = 10
    min_capacity     = 1
    instance_type    = "Standard_D8_v4" # 8CPU/32GB
    disk_size        = 100
  }
}

variable "availability_zones" {
  description = "Azure availability zones"
  default     = [1, 2, 3]
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  type        = string
  default     = "1.18.10"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default = {
    Terraform = true
    THORNode  = true
  }
}
