output "zone" {
  value       = var.zone
  description = "Region"
}

output "cluster_name" {
  value       = google_container_cluster.cluster.name
  description = "GCP zone in region"
}
