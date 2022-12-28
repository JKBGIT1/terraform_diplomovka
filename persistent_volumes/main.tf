resource "kubernetes_persistent_volume_v1" "minio-pv" {
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
        path = "/mnt/data"
      }
    }
  }
}

output "persistent_volume_name" {
  value = kubernetes_persistent_volume_v1.minio-pv.metadata.0.name
}