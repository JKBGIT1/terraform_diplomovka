resource "kubernetes_service_v1" "redis_service" {
  metadata {
    name = var.redis_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.redis_service_name
    }
  }
  spec {
    selector = {
      app = var.redis_pods_name
    }
    port {
      name = "redis-api"
      port = var.redis_port
      target_port = var.redis_port
    }
    type = "ClusterIP"
  }
}