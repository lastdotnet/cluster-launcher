output "location" {
  value       = local.is_zonal ? var.location : local.region
  description = "GCP region"
}

output "cluster_name" {
  value       = google_container_cluster.cluster.name
  description = "Your GCP cluster name"
}

output "project_id" {
  value       = google_container_cluster.cluster.project
  description = "GCP Project ID"
}
