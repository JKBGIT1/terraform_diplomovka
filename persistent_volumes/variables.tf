variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

variable "minio_pv_storage" {
  type = string
  default = "2Gi"
}

variable "minio_pv_access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "minio_pv_storage_class_name" {
  type = string
	default = "hostpath"
}

variable "minio_pv_path" {
	type = string
	default = "/mnt/minio"
}

variable "redis_pv_name" {
	type = string
	default = "redis-pv"
}

variable "redis_pv_storage" {
	type = string
	default = "2Gi"
}

variable "redis_pv_access_modes" {
	type = list(string)
	default = ["ReadWriteOnce"]
}

variable "redis_pv_storage_class_name" {
	type = string
	default = "hostpath"
}

variable "redis_pv_path" {
	type = string
	default = "/mnt/redis"
}

variable "postgres_pv_name" {
  type = string
  default = "postgres-pv"
}

variable "postgres_pv_storage" {
  type = string
  default = "2Gi"
}

variable "postgres_pv_access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "postgres_pv_storage_class_name" {
  type = string
	default = "hostpath"
}

variable "postgres_pv_path" {
	type = string
	default = "/mnt/postgres"
}