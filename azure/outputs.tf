output "resource_group" {
  value       = azurerm_resource_group.rg.name
  description = "Azure resource group"
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.cluster.name
  description = "AKS cluster name"
}
