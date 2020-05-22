terraform {
  backend "local" {
    path = "../../.tf_state/vpc.tfstate"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = [for az in var.az : format("%s%s", var.region, az)]
  public_subnets       = [cidrsubnet(var.vpc_cidr, 9, 0), cidrsubnet(var.vpc_cidr, 9, 1), cidrsubnet(var.vpc_cidr, 9, 2)]
  private_subnets      = [cidrsubnet(var.vpc_cidr, 9, 10), cidrsubnet(var.vpc_cidr, 9, 11), cidrsubnet(var.vpc_cidr, 9, 12)]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}
