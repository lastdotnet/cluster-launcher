variable "token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "cluster_version" {
  description = "DigitalOcean Kubernetes cluster version"
  type        = string
  default     = "1.18.10-do.1"
}

variable "cluster_name" {
  description = "DigitalOcean Kubernetes cluster name"
  type        = string
}

variable "tags" {
  description = "Cluster tags"
  default     = ["Terraform", "THORNode"]
}

variable "node_group_settings" {
  description = "Cluster node group settings"
  type        = map(string)
  default = {
    min_capacity     = 1
    max_capacity     = 10
    instance_type    = "g-8vcpu-32gb"
  }
}

variable "kubeconfig_path" {
  description = "Kuubeconfig file path"
  default     = "~/.kube/config-do"
}
