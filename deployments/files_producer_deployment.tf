resource "kubernetes_deployment_v1" "files_producer_deployment" {
  metadata {
    name = var.files_producer_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_files_producer_replicas
    selector {
      match_labels = {
        app = var.files_producer_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.files_producer_pods_name
        }
      }
      spec {
        container {
          image = var.files_producer_image
          name = var.files_producer_container_name
          port {
            container_port = var.files_producer_port
          }
          env_from {
            config_map_ref {
              name = var.files_producer_config_map_name
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

output "files_producer_pods_name" {
  value = kubernetes_deployment_v1.files_producer_deployment.metadata.0.name
}