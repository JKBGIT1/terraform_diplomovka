resource "kubernetes_service_v1" "broker_service" {
  metadata {
    name = var.broker_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.broker_service_name
    }
  }
  spec {
    selector = {
      app = var.broker_pods_name
    }
    port {
      name = "broker-api"
      port = var.broker_port
      target_port = var.broker_port
    }
    type = "ClusterIP"
  }
}