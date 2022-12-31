resource "kubernetes_deployment_v1" "files_consumer_deployment" {
  metadata {
    name = var.files_consumer_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_files_consumer_replicas
    selector {
      match_labels = {
        app = var.files_consumer_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.files_consumer_pods_name
        }
      }
      spec {
        container {
          image = var.files_consumer_image
          name = var.files_consumer_container_name
          env_from {
            config_map_ref {
              name = var.files_consumer_config_map_name
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