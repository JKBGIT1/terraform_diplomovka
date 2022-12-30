resource "kubernetes_service_v1" "zookeeper_service" {
  metadata {
    name = var.zookeeper_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.zookeeper_service_name
    }
  }
  spec {
    selector = {
      app = var.zookeeper_pods_name
    }
    port {
      name = "zookeeper-api"
      port = var.zookeeper_port
      target_port = var.zookeeper_port
    }
    type = "ClusterIP"
  }
}