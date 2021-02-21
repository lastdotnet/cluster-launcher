variable "token" {
  description = "Linode API token"
  type        = string
}

variable "region" {
  description = "Linode region"
  type        = string
}

variable "cluster_version" {
  description = "Linode Kubernetes cluster version"
  type        = string
  default     = "1.18"
}

variable "kubeconfig_path" {
  description = "Kubeconfig file path"
  type        = string
  default     = "~/.kube/config-linode"
}

variable "cluster_label" {
  description = "Linode Kubernetes cluster label"
  type        = string
}

variable "tags" {
  description = "Cluster tags"
  type        = list(string)
  default     = ["Terraform", "THORNode"]
}

variable "pool_settings" {
  description = "Cluster pool settings"
  type        = map(string)
  default = {
    count         = 3
    instance_type = "g6-dedicated-16" # 16CPU/32GB with dedicated CPU
  }
}
