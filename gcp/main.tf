resource "google_container_cluster" "cluster" {
  name     = "${var.project_id}-cluster"
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = var.nodes.desired_capacity

  min_master_version = var.kubernetes_version

  enable_shielded_nodes = true

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.network.pods
    services_ipv4_cidr_block = var.network.services
  }
}

resource "google_container_node_pool" "nodes" {
  name     = "${var.project_id}-nodes"
  location = google_container_cluster.cluster.location
  cluster  = google_container_cluster.cluster.name

  node_count = var.nodes.desired_capacity

  node_config {
    machine_type = var.nodes.machine_type
    preemptible  = var.nodes.preemptible
    disk_size_gb = var.nodes.disk_size
    disk_type    = var.nodes.disk_type

    tags = var.tags

    labels = {
      env = var.project_id
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  autoscaling {
    min_node_count = var.nodes.min_capacity
    max_node_count = var.nodes.max_capacity
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }
}
