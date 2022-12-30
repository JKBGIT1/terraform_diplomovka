resource "kubernetes_deployment_v1" "broker_deployment" {
  metadata {
    name = var.broker_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_broker_replicas
    selector {
      match_labels = {
        app = var.broker_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.broker_pods_name
        }
      }
      spec {
        container {
          image = var.broker_image
          name = var.broker_container_name
          port {
            container_port = var.broker_port
          }
          env_from {
            config_map_ref {
              name = var.broker_config_map_name
            }
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_deployment_v1.zookeeper_deployment
  ]
}

output "broker_pods_name" {
  value = kubernetes_deployment_v1.broker_deployment.metadata.0.name
}