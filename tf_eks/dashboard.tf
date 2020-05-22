resource "kubectl_manifest" "dashboard" {
  yaml_body = file("manifests/kubernetes-dashboard.yaml")
}
