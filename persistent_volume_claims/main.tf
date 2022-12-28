variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "persistent_volume_name" {
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
    volume_name = var.persistent_volume_name
    storage_class_name = "hostpath"
  }
}

output "persistent_volume_claim_name" {
  value = kubernetes_persistent_volume_claim_v1.minio-pvc.metadata.0.name
}