resource "kubernetes_persistent_volume_v1" "minio_pv" {
  metadata {
    name = "minio-pv"
  }

  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "hostpath"

    persistent_volume_source {
      host_path {
        path = "/mnt/minio"
      }
    }
  }
}

resource "kubernetes_persistent_volume_v1" "redis_pv" {
  metadata {
    name = var.redis_pv_name
  }

  spec {
    capacity = {
      storage = var.redis_pv_storage
    }
    access_modes = var.redis_pv_access_modes
    storage_class_name = var.redis_pv_storage_class_name
    persistent_volume_source {
      host_path {
        path = var.redis_pv_path
      }
    }
  }
}

output "minio_pv_name" {
  value = kubernetes_persistent_volume_v1.minio_pv.metadata.0.name
}

output "redis_pv_name" {
  value = kubernetes_persistent_volume_v1.redis_pv.metadata.0.name
}