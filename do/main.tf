resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.name}-cluster"
  region  = var.region
  ha      = var.control_plane_ha
  version = var.kubernetes_version
  tags    = var.tags

  node_pool {
    name       = "${var.name}-nodes"
    auto_scale = true
    size       = var.node_group_settings.instance_type
    node_count = var.node_group_settings.desired_capacity
    min_nodes  = var.node_group_settings.min_capacity
    max_nodes  = var.node_group_settings.max_capacity
  }

  lifecycle {
    ignore_changes = [node_pool.0.node_count]
  }
}

resource "local_file" "kubeconfig" {
  content         = digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config
  filename        = pathexpand(var.kubeconfig_path)
  file_permission = "0600"
}
