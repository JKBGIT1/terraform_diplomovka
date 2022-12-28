variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "service_name" {
  type = string
  default = "minio-gui"
}

resource "kubernetes_ingress_v1" "minio-ingress" {
  metadata {
    name = "minio-ingress"
    namespace = var.diplomovka_namespace_name
  }
  spec {
    # ingress_class_name = kubernetes_ingress_class_v1.minio-ingress-class.metadata.0.name
    rule {
      host = "localhost"
      http {
        path {
          path = "/"
          backend {
            service {
              name = var.service_name
              port {
                number = 9001
              } 
            }
          }
        }
      }
    }
  }
}