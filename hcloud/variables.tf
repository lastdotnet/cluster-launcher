variable "token" {
  description = "Hetzner Cloud API token"
  type        = string
}

variable "name" {
  description = "The base name used for all resources"
  type        = string
}

variable "location" {
  description = <<EOT
Choose your location (NAME)

ID   NAME   DESCRIPTION             NETWORK ZONE   COUNTRY   CITY
1    fsn1   Falkenstein DC Park 1   eu-central     DE        Falkenstein
2    nbg1   Nuremberg DC Park 1     eu-central     DE        Nuremberg
3    hel1   Helsinki DC Park 1      eu-central     FI        Helsinki
4    ash    Ashburn, VA             us-east        US        Ashburn, VA

See node-launcher service annotations (don't necessarily need to match for Europe)
EOT
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
      count       = 5
      server_type = "ccx32" # 8CPU/32GB with dedicated AMD EPYC CPU
    }
    common = {
      image   = "ubuntu-20.04"
      lb_type = "lb11"
    }
  }
}

variable "versions" {
  description = "Software versions"
  type        = map(string)
  default = {
    kubernetes = "1.21.8"
  }
}

variable "custom_packages" {
  description = "Custom list of packages you want to install"
  type        = list(string)
  default     = []
}

locals {
  network_region = var.location == "ash" ? "us-east" : "eu-central"
}
