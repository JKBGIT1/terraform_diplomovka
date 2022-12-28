variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "pods_name" {
  type = string
  default = "minio"
}

resource "kubernetes_service_v1" "minio-service-api" {
  metadata {
    name = "minio-api"
    namespace = var.diplomovka_namespace_name
    labels = {
      app = "minio-api"
    }
  }
  spec {
    selector = {
      app = var.pods_name
    }
    port {
      name = "minio-api"
      port = 9000
      target_port = 9000
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service_v1" "minio-service-gui" {
  metadata {
    name = "minio-gui"
    namespace = var.diplomovka_namespace_name
    labels = {
      "app" = "minio-gui"
    }
  }
  spec {
    selector = {
      app = var.pods_name
    }
    port {
      name = "minio-gui"
      port = 9001
      target_port = 9001
    }
    type = "LoadBalancer"
  }
}

output "service_name" {
  value = kubernetes_service_v1.minio-service-gui.metadata.0.name
}