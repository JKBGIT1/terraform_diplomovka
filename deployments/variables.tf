variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_deployment_name" {
  type = string
  default = "minio"
}

variable "total_minio_replicas" {
  type = number
  default = 1
}

variable "minio_pod_name" {
  type = string
  default = "minio"
}

variable "minio_image" {
  type = string
  default = "minio/minio:latest"
}

variable "minio_container_name" {
  type = string
  default = "minio"
}

variable "minio_api_port" {
  type = number
  default = 9000
}

variable "minio_console_port" {
  type = number
  default = 9001
}

variable "minio_pvc_name" {
  type = string
  default = "minio-pvc"
}

variable "minio_pv_name" {
  type = string
  default = "minio-pv"
}

variable "minio_secret_name" {
  type = string
  default = "minio-secret"
}

variable "redis_deployment_name" {
  type = string
  default = "redis"
}

variable "total_redis_replicas" {
  type = number
  default = 1
}

variable "redis_pod_name" {
  type = string
  default = "redis"
}

variable "redis_image" {
  type = string
  default = "redis:alpine3.16"
}

variable "redis_container_name" {
  type = string
  default = "redis"
}

variable "redis_port" {
  type = number
  default = 6379
}

variable "redis_pv_name" {
  type = string
  default = "redis-pv"
}

variable "redis_pvc_name" {
  type = string
  default = "redis-pvc"
}

variable "postgres_deployment_name" {
  type = string
  default = "postgres"
}

variable "total_postgres_replicas" {
  type = string
  default = 1
}

variable "postgres_pods_name" {
  type = string
  default = "postgres"
}

variable "postgres_image" {
  type = string
  default = "postgres:15rc1-alpine3.16"
}

variable "postgres_container_name" {
  type = string
  default = "postgres"
}

variable "postgres_port" {
  type = number
  default = 5432
}

variable "postgres_pv_name" {
  type = string
  default = "postgres-pv"
}

variable "postgres_pvc_name" {
  type = string
  default = "postgres-pvc"
}

variable "postgres_secret_name" {
  type = string
  default = "postgres-secret"
}