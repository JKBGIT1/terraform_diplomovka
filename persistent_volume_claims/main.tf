variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

variable "redis_pv_name" {
  type = string
  default = "redis-pv"
}

resource "kubernetes_persistent_volume_claim_v1" "minio_pvc" {
  metadata {
    name = "minio-pvc"
    labels = {
      app = "minio-pvc"
    }
    namespace = var.diplomovka_namespace_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = var.minio_pv_name
    storage_class_name = "hostpath"
  }
}

resource "kubernetes_persistent_volume_claim_v1" "redis_pvc" {
  metadata {
    name = "redis-pvc"
    labels = {
      app = "redis-pvc"
    }
    namespace = var.diplomovka_namespace_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = var.redis_pv_name
    storage_class_name = "hostpath"
  }
}

output "minio_pvc_name" {
  value = kubernetes_persistent_volume_claim_v1.minio_pvc.metadata.0.name
}

output "redis_pvc_name" {
  value = kubernetes_persistent_volume_claim_v1.redis_pvc.metadata.0.name
}