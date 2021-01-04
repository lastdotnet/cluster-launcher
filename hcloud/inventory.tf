resource "local_file" "inventory" {
  filename = "${path.module}/ansible/inventory/inventory.yml"
  content = templatefile("${path.module}/templates/inventory.tpl", {
    nodes = [
      for node in local.cluster_nodes : {
        name       = node.name
        public_ip  = node.ipv4_address
        private_ip = [for x in hcloud_server_network.node_net : x.ip if x.id == "${node.id}-${hcloud_network.net.id}"].0
      }
    ],
    masters = hcloud_server.master,
    workers = hcloud_server.worker,
    vars = [
      "hcloud_token: ${var.token}",
      "hcloud_network_id: ${hcloud_network.net.name}",
      "ansible_ssh_user: ${var.user_name}",
      "cluster_name: ${var.name}",
      "kube_version: v${var.versions.kubernetes}",
      "docker_version: '${var.versions.docker}'",
      "kube_pods_subnet: ${var.network.pods}",
      "kube_service_addresses: ${var.network.services}",
      "apiserver_loadbalancer_domain_name: ${hcloud_load_balancer.lb.ipv4}",
      "loadbalancer_apiserver: {address: ${hcloud_load_balancer_network.lb_net.ip}}"
    ]
  })
}
