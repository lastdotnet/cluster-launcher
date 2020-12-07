resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.cluster_version
  tags    = var.tags

  node_pool {
    name       = "${var.cluster_name}-pool"
    auto_scale = true
    size       = var.node_group_settings["instance_type"]
    min_nodes  = var.node_group_settings["min_capacity"]
    max_nodes  = var.node_group_settings["max_capacity"]
  }
}

resource "local_file" "kubeconfig" {
  content         = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  filename        = pathexpand(var.kubeconfig_path)
  file_permission = "0600"
}
