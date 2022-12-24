terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
    config_context = "docker-desktop"
}

resource "kubernetes_namespace_v1" "diplomovka" {
  metadata {
    name = "diplomovka"
  }
}

resource "kubernetes_deployment_v1" "nginx-deployment" {
  metadata {
    name = "nginx"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx"
          name = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx-service" {
  metadata {
    name = "nginx"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
  }
  spec {
    selector = {
      "app" = kubernetes_deployment_v1.nginx-deployment.metadata.0.name
    }
    type = "NodePort"
    port {
      name = "http"
      node_port = 30201
      port = 80
      target_port = 80
    }
  }
}


# resource "kubernetes_persistent_volume" "minio-pv" {
#   metadata {
#     name = "minio-pv"
#   }

#   spec {
#     capacity = {
#       "storage" = "2Gi"
#     }
#     access_modes = ["ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Retain"

#     storage_class_name = "standard"

#     persistent_volume_source {
#       host_path {
#         path = "/mnt/minio"
#       } 
#     }
#   }

#   depends_on = [
#     kubernetes_namespace.diplomovka
#   ]
# }


# resource "kubernetes_persistent_volume_claim" "minio-pvc" {
#   metadata {
#     name = "minio-pvc"
#     labels = {
#       "app" = "minio-pvc"
#     }
#     namespace = "diplomovka"
#   }

#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "1Gi"
#       }
#     }
#     volume_name = "minio-pvc"
#     storage_class_name = "standard"
#   }

#   depends_on = [
#     kubernetes_persistent_volume.minio-pv
#   ]
# }

# resource "kubernetes_pod" "minio-pod" {
#   metadata {
#     name = "minio"
#     namespace = "diplomovka"
#     labels = {
#         app = "minio"
#     }
#   }

#   spec {
#     container {
#       image = "minio/minio:latest"
#       name = "minio"

#       # env {
#       #   name = "MINIO_ROOT_USER"
#       #   value = "root"
#       # }

#       # env {
#       #   name = "MINIO_ROOT_PASSWORD"
#       #   value = "password"
#       # }

#       env {
#         name  = "MINIO_ACCESS_KEY"
#         value = "myaccesskey"
#       }

#       env {
#         name  = "MINIO_SECRET_KEY"
#         value = "mysecretkey"
#       }

#       port {
#         container_port = 9000
#       }

#       port {
#         container_port = 9001
#       }

#       # readiness_probe {
#       #   http_get {
#       #     path = "minio/health/ready"
#       #     port = 9000
#       #   }
#       #   initial_delay_seconds = 30
#       #   period_seconds = 15
#       #   timeout_seconds = 10
#       #   success_threshold = 1
#       #   failure_threshold = 3
#       # }

#       volume_mount {
#         name = "minio-pv"
#         mount_path = "/data"
#       }
#     }

#     volume {
#       name = "minio-pv"
#       persistent_volume_claim {
#         claim_name = kubernetes_persistent_volume_claim.minio-pvc.metadata.0.name
#       }
#     }
#   }

#   depends_on = [
#     kubernetes_persistent_volume_claim.minio-pvc
#   ]
# }

# resource "kubernetes_service" "minio-service" {
#   metadata {
#     name = "minio"
#     namespace = "diplomovka"
#     labels = {
#       app = "minio"
#     }
#   }
#   spec {
#     selector = {
#       "app" = "kubernetes_pod.minio-pod.metadata.0.labels.app"
#     }
#     port {
#       name = "minio-api"
#       port = 9000
#       target_port = 9000
#     }
#     port {
#       name = "minio-gui"
#       port = 9001
#       target_port = 9001
#     }
#     type = "NodePort"
#   }

#   depends_on = [
#     kubernetes_pod.minio-pod
#   ]
# }