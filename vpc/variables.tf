variable "region" {
  description = "AWS region"
  type        = string
}

variable "az" {
  default = ["a", "b", "c"]
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}