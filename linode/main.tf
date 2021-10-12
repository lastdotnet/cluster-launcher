resource "linode_lke_cluster" "cluster" {
  label       = var.cluster_label
  k8s_version = var.cluster_version
  region      = var.region
  tags        = var.tags

  pool {
    type  = var.pool_settings["instance_type"]
    count = var.pool_settings["desired_capacity"]

    autoscaler {
      min = var.pool_settings["min_capacity"]
      max = var.pool_settings["max_capacity"]
    }
  }
}

resource "local_file" "cluster" {
  content         = base64decode(linode_lke_cluster.cluster.kubeconfig)
  filename        = pathexpand(var.kubeconfig_path)
  file_permission = "0600"
}
