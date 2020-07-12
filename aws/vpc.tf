module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                    = var.cluster_name
  cidr                    = var.vpc_cidr
  azs                     = [for az in var.az : format("%s%s", var.region, az)]
  private_subnets         = [cidrsubnet(var.vpc_cidr, 4, 1), cidrsubnet(var.vpc_cidr, 4, 2), cidrsubnet(var.vpc_cidr, 4, 3)]
  public_subnets          = [cidrsubnet(var.vpc_cidr, 4, 4), cidrsubnet(var.vpc_cidr, 4, 5), cidrsubnet(var.vpc_cidr, 4, 6)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
