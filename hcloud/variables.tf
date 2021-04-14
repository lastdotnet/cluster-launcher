variable "token" {
  description = "Hetzner Cloud API token"
  type        = string
}

variable "name" {
  description = "The base name used for all resources"
  type        = string
}

variable "user_name" {
  description = "The admin user name for the nodes"
  type        = string
}

variable "ssh_key" {
  description = "The ssh key to be used for authentication"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "cloud_config" {
  description = "cloud-init file path"
  type        = string
  default     = "./templates/cloud-config.tpl"
}

variable "network" {
  description = "Network settings"
  type        = map(string)
  default = {
    zone     = "eu-central"
    main     = "10.0.0.0/8"
    sub      = "10.0.0.0/24"
    pods     = "10.1.0.0/16"
    services = "10.2.0.0/16"
  }
}

variable "nodes" {
  description = "Node settings"
  type        = map(map(string))
  default = {
    master = {
      count       = 3
      server_type = "cpx11" # 2CPU/2GB
    }
    worker = {
      count       = 3
      server_type = "ccx31" # 8CPU/32GB with dedicated CPU
    }
    common = {
      location = "nbg1" # See node-launcher service annotations (don't necessarily need to match)
      image    = "ubuntu-20.04"
      lb_type  = "lb11"
    }
  }
}

variable "versions" {
  description = "Software versions"
  type        = map(string)
  default = {
    kubernetes = "1.19.9"
  }
}

variable "custom_packages" {
  description = "Custom list of packages you want to install"
  type        = list(string)
  default     = []
}
