module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                    = var.cluster_name
  cidr                    = var.vpc_cidr
  azs                     = [for az in var.az : format("%s%s", var.region, az)]
  public_subnets          = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 2), cidrsubnet(var.vpc_cidr, 8, 3)]
  enable_nat_gateway      = false
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
