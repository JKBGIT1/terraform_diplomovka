resource "kubernetes_ingress_v1" "minio_ingress" {
  metadata {
    name = var.minio_ingress_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
    # ingress_class_name = kubernetes_ingress_class_v1.minio-ingress-class.metadata.0.name
    rule {
      host = var.host_name
      http {
        path {
          path = "/"
          backend {
            service {
              name = var.minio_gui_service_name
              port {
                number = var.minio_gui_port
              } 
            }
          }
        }
      }
    }
  }
}