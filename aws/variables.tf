variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  description = "AWS availability zones"
  default = ["a", "b", "c"]
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.16"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {
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
    instance_type    = "t3.xlarge"
    disk_size        = 100
  }
}
