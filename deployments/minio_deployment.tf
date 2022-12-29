
resource "kubernetes_deployment_v1" "minio_deployment" {
  metadata {
    name = var.minio_deployment_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = var.total_minio_replicas
    selector {
      match_labels = {
        app = var.minio_deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.minio_pod_name
        }
      }
      spec {
        container {
          image = var.minio_image
          name = var.minio_container_name
          port {
            container_port = var.minio_api_port
          }
          port {
            container_port = var.minio_console_port
          }
          env_from {
            secret_ref {
              name = var.minio_secret_name
            }
          }
          args = ["server", "/data", "--console-address", ":9001"]
          readiness_probe {
            http_get {
              path = "/minio/health/ready"
              port = var.minio_api_port
            }
            initial_delay_seconds = 10
            period_seconds = 20
          }

          liveness_probe {
            http_get {
              path = "/minio/health/live"
              port = var.minio_api_port
            }
            initial_delay_seconds = 10
            period_seconds = 20
          }
          volume_mount {
            name = var.minio_pv_name
            mount_path = "/data"
          }
        }

        volume {
          name = var.minio_pv_name
          persistent_volume_claim {
            claim_name = var.minio_pvc_name
          }
        }
      }
    }
  }
}

output "minio_pods_name" {
  value = kubernetes_deployment_v1.minio_deployment.metadata.0.name
}