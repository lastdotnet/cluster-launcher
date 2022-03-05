resource "hcloud_load_balancer_network" "lb_net" {
  load_balancer_id = hcloud_load_balancer.lb.id
  subnet_id        = hcloud_network_subnet.subnet.id
}

resource "hcloud_load_balancer" "lb" {
  name               = "${var.name}-lb"
  load_balancer_type = var.nodes.common.lb_type
  location           = var.location
}

resource "hcloud_load_balancer_service" "lb_service" {
  load_balancer_id = hcloud_load_balancer.lb.id
  protocol         = "tcp"
  listen_port      = 6443
  destination_port = 6443
}

resource "hcloud_load_balancer_target" "lb_target" {
  count            = var.nodes.master.count
  type             = "server"
  load_balancer_id = hcloud_load_balancer.lb.id
  server_id        = element(hcloud_server.master.*.id, count.index)
  use_private_ip   = true

  depends_on = [
    hcloud_server_network.node_net,
    hcloud_load_balancer_network.lb_net
  ]
}
