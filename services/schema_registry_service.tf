resource "kubernetes_service_v1" "schema_registry_service" {
  metadata {
    name = var.schema_registry_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.schema_registry_service_name
    }
  }
  spec {
    selector = {
      app = var.schema_registry_pods_name
    }
    port {
      name = "schema-registry-api"
      port = var.schema_registry_port
      target_port = var.schema_registry_port
    }
    type = "ClusterIP"
  }
}

output "schema_registry_service_name" {
  value = kubernetes_service_v1.schema_registry_service.metadata.0.name
}