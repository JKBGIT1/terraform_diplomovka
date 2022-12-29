resource "kubernetes_persistent_volume_v1" "minio_pv" {
  metadata {
    name = var.minio_pv_name
  }

  spec {
    capacity = {
      storage = var.minio_pv_storage
    }
    access_modes = var.minio_pv_access_modes
    storage_class_name = var.minio_pv_storage_class_name

    persistent_volume_source {
      host_path {
        path = var.minio_pv_path
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

resource "kubernetes_persistent_volume_v1" "postgres_pv" {
  metadata {
    name = var.postgres_pv_name
  }

  spec {
    capacity = {
      storage = var.postgres_pv_storage
    }
    access_modes = var.postgres_pv_access_modes
    storage_class_name = var.postgres_pv_storage_class_name
    persistent_volume_source {
      host_path {
        path = var.postgres_pv_path
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

output "postgres_pv_name" {
  value = kubernetes_persistent_volume_v1.postgres_pv.metadata.0.name
}