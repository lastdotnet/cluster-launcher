resource "hcloud_ssh_key" "key" {
  name       = "${var.name}-key"
  public_key = file("${var.ssh_key}.pub")
}

data "template_file" "ci" {
  template = templatefile(var.cloud_config, {
    custom_packages = var.custom_packages
    user = {
      name = var.user_name
      key  = file("${var.ssh_key}.pub")
    }
  })
}
