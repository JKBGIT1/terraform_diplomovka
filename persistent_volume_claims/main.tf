resource "kubernetes_persistent_volume_claim_v1" "minio_pvc" {
  metadata {
    name = var.minio_pvc_name
    labels = {
      app = var.minio_pvc_name
    }
    namespace = var.diplomovka_namespace_name
  }

  spec {
    access_modes = var.minio_access_modes
    resources {
      requests = {
        storage = var.minio_pvc_storage
      }
    }
    volume_name = var.minio_pv_name
    storage_class_name = var.minio_storage_class_name
  }
}

resource "kubernetes_persistent_volume_claim_v1" "redis_pvc" {
  metadata {
    name = var.redis_pvc_name
    labels = {
      app = var.redis_pvc_name
    }
    namespace = var.diplomovka_namespace_name
  }

  spec {
    access_modes = var.redis_access_modes
    resources {
      requests = {
        storage = var.redis_pvc_storage
      }
    }
    volume_name = var.redis_pv_name
    storage_class_name = var.redis_storage_class_name
  }
}

output "minio_pvc_name" {
  value = kubernetes_persistent_volume_claim_v1.minio_pvc.metadata.0.name
}

output "redis_pvc_name" {
  value = kubernetes_persistent_volume_claim_v1.redis_pvc.metadata.0.name
}