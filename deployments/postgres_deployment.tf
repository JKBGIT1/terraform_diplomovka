resource "kubernetes_deployment_v1" "postgres_deployment" {
  metadata {
    name = var.postgres_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_postgres_replicas
    selector {
      match_labels = {
        app = var.postgres_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.postgres_pods_name
        }
      }
      spec {
        container {
          image = var.postgres_image
          name = var.postgres_container_name
          port {
            container_port = var.postgres_port
          }
          env_from {
            secret_ref {
              name = var.postgres_secret_name
            }
          }
          volume_mount {
            name = var.postgres_pv_name
            mount_path = "/data"
          }
        }

        volume {
          name = var.postgres_pv_name
          persistent_volume_claim {
            claim_name = var.postgres_pvc_name
          }
        }
      }
    }
  }
}

output "postgres_pods_name" {
  value = kubernetes_deployment_v1.postgres_deployment.metadata.0.name
}