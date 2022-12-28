resource "kubernetes_namespace_v1" "diplomovka" {
  metadata {
    name = "diplomovka"
  }
}

output "namespace_name" {
  value = kubernetes_namespace_v1.diplomovka.metadata.0.name
}