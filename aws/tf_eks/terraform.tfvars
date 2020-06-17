region = "us-east-1"

tags = {
  Terraform = true
}

vpc_cidr = "10.90.0.0/16"

cluster_name = "eks-thor"

cluster_version = "1.16"

node_group_settings = {
  desired_capacity = 1
  max_capacity     = 4
  min_capacity     = 1
  instance_type    = "t3.xlarge"
  disk_size        = 50
}