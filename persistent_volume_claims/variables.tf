variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

variable "minio_pvc_name" {
  type = string
  default = "minio-pvc"
}

variable "minio_access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "minio_pvc_storage" {
  type = string
  default = "1Gi"
}

variable "minio_storage_class_name" {
  type = string
  default = "hostpath"
}

variable "redis_pv_name" {
  type = string
  default = "redis-pv"
}

variable "redis_pvc_name" {
  type = string
  default = "redis-pvc"
}

variable "redis_access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "redis_pvc_storage" {
  type = string
  default = "1Gi"
}

variable "redis_storage_class_name" {
  type = string
  default = "hostpath"
}

variable "postgres_pv_name" {
  type = string
  default = "postgres-pv"
}

variable "postgres_pvc_name" {
  type = string
  default = "postgres-pvc"
}

variable "postgres_access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "postgres_pvc_storage" {
  type = string
  default = "1Gi"
}

variable "postgres_storage_class_name" {
  type = string
  default = "hostpath"
}