variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.18"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default = {
    Terraform = true
    THORNode  = true
  }
}

variable "node_group_settings" {
  description = "Cluster node group settings"
  type        = map(string)
  default = {
    desired_capacity = 1
    max_capacity     = 4
    min_capacity     = 1
    instance_type    = "m5.2xlarge" # 8CPU/32GB
    disk_size        = 100
  }
}
