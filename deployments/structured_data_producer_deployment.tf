resource "kubernetes_deployment_v1" "structured_data_producer_deployment" {
  metadata {
    name = var.structured_data_producer_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_structured_data_producer_replicas
    selector {
      match_labels = {
        app = var.structured_data_producer_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.structured_data_producer_pods_name
        }
      }
      spec {
        container {
          image = var.structured_data_producer_image
          name = var.structured_data_producer_container_name
          port {
            container_port = var.structured_data_producer_port
          }
          env_from {
            config_map_ref {
              name = var.structured_data_producer_config_map_name
            }
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_deployment_v1.zookeeper_deployment,
    kubernetes_deployment_v1.broker_deployment,
    kubernetes_deployment_v1.schema_registry_deployment
  ]
}

output "structured_data_producer_pods_name" {
  value = kubernetes_deployment_v1.structured_data_producer_deployment.metadata.0.name
}