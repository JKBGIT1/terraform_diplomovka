resource "kubernetes_service_v1" "postgres_service" {
  metadata {
    name = var.postgres_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.postgres_service_name
    }
  }
  spec {
    selector = {
      app = var.postgres_pods_name
    }
    port {
      name = "postgres-api"
      port = var.postgres_port
      target_port = var.postgres_port
    }
    type = "ClusterIP"
  }
}