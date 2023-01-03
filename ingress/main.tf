resource "kubernetes_ingress_v1" "minio_ingress" {
  metadata {
    name = var.minio_ingress_name
    namespace = var.diplomovka_namespace_name
  }
  spec {
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

# resource "kubernetes_ingress_v1" "files_producer_ingress" {
#   metadata {
#     name = var.files_producer_ingress_name
#     namespace = var.diplomovka_namespace_name
#   }
#   spec {
#     rule {
#       host = var.host_name
#       http {
#         path {
#           path = var.files_producer_path
#           backend {
#             service {
#               name = var.files_producer_service_name
#               port {
#                 number = var.files_producer_port
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }