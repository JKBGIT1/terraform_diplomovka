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
    name = "redis-pv"
  }

  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "hostpath"
    persistent_volume_source {
      host_path {
        path = "/mnt/redis"
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