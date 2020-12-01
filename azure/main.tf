resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-resources"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.name}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.name}-k8s"
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  default_node_pool {
    name                = "default"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    node_count          = var.node_pool_settings.desired_capacity
    max_count           = var.node_pool_settings.max_capacity
    min_count           = var.node_pool_settings.min_capacity
    vm_size             = var.node_pool_settings.instance_type
    os_disk_size_gb     = var.node_pool_settings.disk_size
    availability_zones  = var.availability_zones
    tags                = var.tags

    node_labels = {
      Environment = "${var.name}-${var.location}"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [default_node_pool.0.node_count]
  }
}
