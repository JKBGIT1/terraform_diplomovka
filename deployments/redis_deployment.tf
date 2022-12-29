resource "kubernetes_deployment_v1" "redis_deployment" {
  metadata {
    name = var.redis_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_redis_replicas
    selector {
      match_labels = {
        app = var.redis_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.redis_pod_name
        }
      }
      spec {
        container {
          image = var.redis_image
          name = var.redis_container_name
          port {
            container_port = var.redis_port
          }
          volume_mount {
            name = var.redis_pv_name
            mount_path = "/data"
          }
        }

        volume {
          name = var.redis_pv_name
          persistent_volume_claim {
            claim_name = var.redis_pvc_name
          }
        }
      }
    }
  }
}

output "redis_pods_name" {
  value = kubernetes_deployment_v1.redis_deployment.metadata.0.name
}