variable "token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "kubernetes_version" {
  description = "DigitalOcean Kubernetes cluster version"
  type        = string
  default     = "1.21.14-do.1"
}

variable "control_plane_ha" {
  description = "Highly available kubernetes control plane"
  type        = bool
  default     = true
}

variable "name" {
  description = "The base name used for all resources"
  type        = string
}

variable "tags" {
  description = "Cluster tags"
  type        = list(string)
  default     = ["Terraform", "THORNode"]
}

variable "node_group_settings" {
  description = "Cluster node group settings"
  type        = map(string)
  default = {
    desired_capacity = 1
    min_capacity     = 1
    max_capacity     = 10
    instance_type    = "c-32" # 32CPU/64GB with dedicated CPU
  }
}

variable "kubeconfig_path" {
  description = "Kuubeconfig file path"
  type        = string
  default     = "~/.kube/config-do"
}
