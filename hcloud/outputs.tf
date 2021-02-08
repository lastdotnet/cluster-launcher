output "hcloud_config" {
  value       = "${var.user_name}@${local.cluster_nodes.0.ipv4_address}:~/.kube/config"
  description = "The connection to the first master"
}
