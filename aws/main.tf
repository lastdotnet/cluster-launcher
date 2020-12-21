module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  subnets      = module.vpc.public_subnets
  vpc_id       = module.vpc.vpc_id
  tags         = merge({ "Name" = var.cluster_name }, var.tags)

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = var.node_group_settings["disk_size"]
  }

  node_groups = {
    "main-0" = {
      subnets          = [module.vpc.public_subnets[0]]
      desired_capacity = var.node_group_settings["desired_capacity"]
      max_capacity     = var.node_group_settings["max_capacity"]
      min_capacity     = var.node_group_settings["min_capacity"]
      instance_type    = var.node_group_settings["instance_type"]

      k8s_labels = {
        Environment = "${var.cluster_name}-${var.region}"
      }
      additional_tags = var.tags
    }
    "main-1" = {
      subnets          = [module.vpc.public_subnets[1]]
      desired_capacity = var.node_group_settings["desired_capacity"]
      max_capacity     = var.node_group_settings["max_capacity"]
      min_capacity     = var.node_group_settings["min_capacity"]
      instance_type    = var.node_group_settings["instance_type"]

      k8s_labels = {
        Environment = "${var.cluster_name}-${var.region}"
      }
      additional_tags = var.tags
    }
    "main-2" = {
      subnets          = [module.vpc.public_subnets[2]]
      desired_capacity = var.node_group_settings["desired_capacity"]
      max_capacity     = var.node_group_settings["max_capacity"]
      min_capacity     = var.node_group_settings["min_capacity"]
      instance_type    = var.node_group_settings["instance_type"]

      k8s_labels = {
        Environment = "${var.cluster_name}-${var.region}"
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
