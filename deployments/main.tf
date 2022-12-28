variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "persistent_volume_claim_name" {
  type = string
  default = "minio-pvc"
}

resource "kubernetes_deployment_v1" "minio-deployment" {
  metadata {
    name = "minio"
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "minio"
      }
    }
    template {
      metadata {
        labels = {
          app = "minio"
        }
      }
      spec {
        container {
          image = "minio/minio:latest"
          name = "minio"
          port {
            container_port = 9000
          }
          port {
            container_port = 9001
          }

          env {
            name = "MINIO_ROOT_USER"
            value = "root"
          }
          env {
            name = "MINIO_ROOT_PASSWORD"
            value = "password"
          }
          args = ["server", "/data", "--console-address", ":9001"]
          readiness_probe {
            http_get {
              path = "/minio/health/ready"
              port = 9000
            }
            initial_delay_seconds = 10
            period_seconds = 20
          }

          liveness_probe {
            http_get {
              path = "/minio/health/live"
              port = 9000
            }
            initial_delay_seconds = 10
            period_seconds = 20
          }
          volume_mount {
            name = "minio-pv"
            mount_path = "/data"
          }
        }

        volume {
          name = "minio-pv"
          persistent_volume_claim {
            claim_name = var.persistent_volume_claim_name
          }
        }
      }
    }
  }
}

output "pods_name" {
  value = kubernetes_deployment_v1.minio-deployment.metadata.0.name
}