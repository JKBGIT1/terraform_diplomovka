resource "kubernetes_deployment_v1" "schema_registry_deployment" {
  metadata {
    name = var.schema_registry_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_schema_registry_replicas
    selector {
      match_labels = {
        app = var.schema_registry_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.schema_registry_pods_name
        }
      }
      spec {
        container {
          image = var.schema_registry_image
          name = var.schema_registry_container_name
          port {
            container_port = var.schema_registry_port
          }
          env_from {
            config_map_ref {
              name = var.schema_registry_config_map_name
            }
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_deployment_v1.zookeeper_deployment,
    kubernetes_deployment_v1.broker_deployment
  ]
}

output "schema_registry_pods_name" {
  value = kubernetes_deployment_v1.schema_registry_deployment.metadata.0.name
}