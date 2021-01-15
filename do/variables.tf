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
  default     = "1.18.10-do.3"
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
    instance_type    = "g-8vcpu-32gb"
  }
}

variable "kubeconfig_path" {
  description = "Kuubeconfig file path"
  type        = string
  default     = "~/.kube/config-do"
}
