variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  description = "Customized AWS availability zones"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.24"
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
  type = object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_types   = list(string)
    disk_size        = number
  })
  default = {
    desired_capacity = 1
    min_capacity     = 1
    max_capacity     = 10
    instance_types   = ["m5a.4xlarge"] # 16CPU/64GB
    disk_size        = 100
  }
}
