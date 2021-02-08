resource "hcloud_network" "net" {
  name     = "${var.name}-net"
  ip_range = var.network.main
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.net.id
  type         = "cloud"
  network_zone = var.network.zone
  ip_range     = var.network.sub
}
