variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  default = ["a", "b", "c"]
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = null
}

variable "node_group_settings" {
  description = "Cluster node group settings"
  type        = map(string)
  default = {
    desired_capacity = 1
    max_capacity     = 1
    min_capacity     = 1
    instance_type    = "t3.xlarge"
    disk_size        = 20
  }
}
