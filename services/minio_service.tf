resource "kubernetes_service_v1" "minio_service_api" {
  metadata {
    name = var.minio_api_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.minio_api_service_name
    }
  }
  spec {
    selector = {
      app = var.minio_pods_name
    }
    port {
      name = "minio-api"
      port = var.minio_api_port
      target_port = var.minio_api_port
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service_v1" "minio_service_gui" {
  metadata {
    name = var.minio_gui_service_name
    namespace = var.diplomovka_namespace_name
    labels = {
      app = var.minio_gui_service_name
    }
  }
  spec {
    selector = {
      app = var.minio_pods_name
    }
    port {
      name = "minio-gui"
      port = var.minio_gui_port
      target_port = var.minio_gui_port
    }
    type = "ClusterIP"
  }
}

output "minio_gui_service_name" {
  value = kubernetes_service_v1.minio_service_gui.metadata.0.name
}