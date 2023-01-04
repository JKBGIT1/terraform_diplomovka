resource "kubernetes_service_v1" "structured_data_producer_service" {
  metadata {
    name = var.structured_data_producer_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.structured_data_producer_service_name
    }
  }
  spec {
    selector = {
      app = var.structured_data_producer_pods_name
    }
    port {
      name = "structured-data-producer-api"
      port = var.structured_data_producer_port
      target_port = var.structured_data_producer_target_port
    }
    type = "ClusterIP"
  }
}

output "structured_data_producer_service_name" {
  value = kubernetes_service_v1.structured_data_producer_service.metadata.0.name
}