variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

resource "kubernetes_persistent_volume_claim_v1" "minio-pvc" {
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

output "minio_pvc_name" {
  value = kubernetes_persistent_volume_claim_v1.minio-pvc.metadata.0.name
}