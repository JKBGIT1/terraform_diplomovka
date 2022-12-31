resource "kubernetes_service_v1" "files_producer_service" {
  metadata {
    name = var.files_producer_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.files_producer_service_name
    }
  }
  spec {
    selector = {
      app = var.files_producer_pods_name
    }
    port {
      name = "files-producer-api"
      port = var.files_producer_port
      target_port = var.files_producer_port
    }
    type = "LoadBalancer"
  }
}