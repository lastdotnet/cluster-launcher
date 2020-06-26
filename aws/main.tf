module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  subnets      = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id
  tags         = merge({ "Name" = var.cluster_name }, var.tags)

  worker_groups = [
    {
      instance_type                 = var.node_group_settings["instance_type"]
      asg_desired_capacity          = var.node_group_settings["desired_capacity"]
      asg_max_size                  = var.node_group_settings["max_capacity"]
      asg_min_size                  = var.node_group_settings["min_capacity"]
      root_volume_size              = var.node_group_settings["disk_size"]
      additional_security_group_ids = [aws_security_group.worker_thornode.id]
      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]
    }
  ]

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
