resource "kubernetes_namespace" "thor" {
  metadata {
    name = "thor"
  }
}