resource "kubernetes_deployment_v1" "zookeeper_deployment" {
  metadata {
    name = var.zookeeper_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_zookeeper_replicas
    selector {
      match_labels = {
        app = var.zookeeper_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.zookeeper_pods_name
        }
      }
      spec {
        container {
          image = var.zookeeper_image
          name = var.zookeeper_container_name
          port {
            container_port = var.zookeeper_port
          }
          env_from {
            config_map_ref {
              name = var.zookeeper_config_map_name
            }
          }
          readiness_probe {
            exec {
              command = ["echo", "srvr", "|", "nc", "zookeeper", tostring(var.zookeeper_port)]
            }
            initial_delay_seconds = 10
            period_seconds = 10
            timeout_seconds = 1
            failure_threshold = 20
            success_threshold = 1
          }
        }
      }
    }
  }
}

output "zookeeper_pods_name" {
  value = kubernetes_deployment_v1.zookeeper_deployment.metadata.0.name
}