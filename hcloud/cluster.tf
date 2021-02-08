resource "hcloud_server_network" "node_net" {
  count     = length(local.cluster_nodes)
  server_id = element(local.cluster_nodes.*.id, count.index)
  subnet_id = hcloud_network_subnet.subnet.id
}

resource "hcloud_server" "master" {
  count = var.nodes.master.count
  name  = "master${count.index + 1}"

  server_type = var.nodes.master.server_type

  location = var.nodes.common.location
  image    = var.nodes.common.image

  ssh_keys  = [hcloud_ssh_key.key.id]
  user_data = data.template_file.ci.rendered
}

resource "hcloud_server" "worker" {
  count = var.nodes.worker.count
  name  = "worker${count.index + 1}"

  server_type = var.nodes.worker.server_type

  location = var.nodes.common.location
  image    = var.nodes.common.image

  ssh_keys  = [hcloud_ssh_key.key.id]
  user_data = data.template_file.ci.rendered
}

locals {
  cluster_nodes = concat(hcloud_server.master, hcloud_server.worker)
}
