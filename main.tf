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

# resource "kubernetes_ingress_class_v1" "minio-ingress-class" {
#   metadata {
#     name = "minio-ingress-class"
#   }
#   parameters {
#     controller = "nginx"
#   }
# }

resource "kubernetes_persistent_volume_v1" "minio-pv" {
  metadata {
    name = "minio-pv"
  }

  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    storage_class_name = "hostpath"

    persistent_volume_source {
      host_path {
        path = "/mnt/data"
      }
    }
  }

  depends_on = [
    kubernetes_namespace_v1.diplomovka
  ]
}

resource "kubernetes_persistent_volume_claim_v1" "minio-pvc" {
  metadata {
    name = "minio-pvc"
    labels = {
      app = "minio-pvc"
    }
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
  }

  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.minio-pv.metadata.0.name
    storage_class_name = "hostpath"
  }

  depends_on = [
    kubernetes_persistent_volume_v1.minio-pv
  ]
}


resource "kubernetes_deployment_v1" "minio-deployment" {
  metadata {
    name = "minio"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
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
            claim_name = kubernetes_persistent_volume_claim_v1.minio-pvc.metadata.0.name
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_persistent_volume_claim_v1.minio-pvc
  ]
}

resource "kubernetes_service_v1" "minio-service-api" {
  metadata {
    name = "minio-api"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
    labels = {
      app = "minio-api"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.minio-deployment.metadata.0.name
    }
    # only minio-api working
    port {
      name = "minio-api"
      port = 9000
      target_port = 9000
    }
    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_deployment_v1.minio-deployment
  ]
}

resource "kubernetes_service_v1" "minio-service-gui" {
  metadata {
    name = "minio-gui"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
    labels = {
      "app" = "minio-gui"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.minio-deployment.metadata.0.name
    }
    port {
      name = "minio-gui"
      port = 9001
      target_port = 9001
    }
    type = "NodePort"
  }
  depends_on = [
    kubernetes_deployment_v1.minio-deployment
  ]
}

resource "kubernetes_ingress_v1" "minio-ingress" {
  metadata {
    name = "minio-ingress"
    namespace = kubernetes_namespace_v1.diplomovka.metadata.0.name
  }
  spec {
    # ingress_class_name = kubernetes_ingress_class_v1.minio-ingress-class.metadata.0.name
    rule {
      host = "localhost"
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service_v1.minio-service-gui.metadata.0.name
              port {
                number = 9001
              } 
            }
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_service_v1.minio-service-gui
  ]
}