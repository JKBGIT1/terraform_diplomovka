variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_pvc_name" {
  type = string
  default = "minio-pvc"
}

variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

variable "minio_secret_name" {
  type = string
  default = "minio-secret"
}

variable "redis_pv_name" {
  type = string
  default = "redis-pv"
}

variable "redis_pvc_name" {
  type = string
  default = "redis-pvc"
}

resource "kubernetes_deployment_v1" "minio_deployment" {
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
          env_from {
            secret_ref {
              name = var.minio_secret_name
            }
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

resource "kubernetes_deployment_v1" "redis_deployment" {
  metadata {
    name = "redis"
    namespace = var.diplomovka_namespace_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis"
        }
      }
      spec {
        container {
          image = "redis:alpine3.16"
          name = "redis"
          port {
            container_port = 6379
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

output "minio_pods_name" {
  value = kubernetes_deployment_v1.minio_deployment.metadata.0.name
}

output "redis_pods_name" {
  value = kubernetes_deployment_v1.redis_deployment.metadata.0.name
}