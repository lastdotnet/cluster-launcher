terraform {
  backend "local" {
    path = "../../.tf_state/cluster_tf.tfstate"
  }
}

module "eks" {
  source       = "github.com/terraform-aws-modules/terraform-aws-eks?ref=v12.0.0"
  cluster_name = var.cluster_name
  subnets      = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id
  tags         = merge({ "Name" = var.cluster_name }, var.tags)

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = var.node_group_settings["disk_size"]
  }

  node_groups = {
    main = {
      desired_capacity = var.node_group_settings["desired_capacity"]
      max_capacity     = var.node_group_settings["max_capacity"]
      min_capacity     = var.node_group_settings["min_capacity"]
      instance_type    = var.node_group_settings["instance_type"]

      k8s_labels = {
        Environment = "test-${var.region}"
      }
      additional_tags = var.tags
    }
  }

  enable_irsa = true
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  cluster_version  = var.cluster_version
  write_kubeconfig = true
}

//locals {
//  oidc_provider_url = split("https://", module.eks.cluster_oidc_issuer_url)[1]
//}
