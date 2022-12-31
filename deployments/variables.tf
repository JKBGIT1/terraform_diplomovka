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

variable "minio_pods_name" {
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

variable "zookeeper_deployment_name" {
  type = string
  default = "zookeeper"
}

variable "total_zookeeper_replicas" {
  type = number
  default = 1
}

variable "zookeeper_pods_name" {
  type = string
  default = "zookeeper"
}

variable "zookeeper_image" {
  type = string
  default = "confluentinc/cp-zookeeper:7.2.1"
}

variable "zookeeper_container_name" {
  type = string
  default = "zookeeper"
}

variable "zookeeper_port" {
  type = number
  default = 2181
}

variable "zookeeper_config_map_name" {
  type = string
  default = "zookeeper-config-map"
}

variable "broker_deployment_name" {
  type = string
  default = "broker"
}

variable "total_broker_replicas" {
  type = number
  default = 1
}

variable "broker_pods_name" {
  type = string
  default = "broker"
}

variable "broker_image" {
  type = string
  default = "confluentinc/cp-kafka:6.1.9"
}

variable "broker_container_name" {
  type = string
  default = "broker"
}

variable "broker_port" {
  type = number
  default = 29092
}

variable "broker_config_map_name" {
  type = string
  default = "broker-config-map"
}

variable "schema_registry_deployment_name" {
  type = string
  default = "registry"
}

variable "total_schema_registry_replicas" {
  type = number
  default = 1
}

variable "schema_registry_pods_name" {
  type = string
  default = "registry"
}

variable "schema_registry_image" {
  type = string
  default = "confluentinc/cp-schema-registry:7.2.1"
}

variable "schema_registry_container_name" {
  type = string
  default = "registry"
}

variable "schema_registry_port" {
  type = number
  default = 8081
}

variable "schema_registry_config_map_name" {
  type = string
  default = "schema-registry-config-map"
}

variable "files_consumer_deployment_name" {
  type = string
  default = "files-consumer"
}

variable "total_files_consumer_replicas" {
  type = number
  default = 1
}

variable "files_consumer_pods_name" {
  type = string
  default = "files-consumer"
}

variable "files_consumer_image" {
  type = string
  default = "ykbhlvck/files_consumer:latest"
}

variable "files_consumer_container_name" {
  type = string
  default = "files-consumer"
}

variable "files_consumer_config_map_name" {
  type = string
  default = "files-consumer-config-map"
}

variable "files_producer_deployment_name" {
  type = string
  default = "files-producer"
}

variable "total_files_producer_replicas" {
  type = number
  default = 1
}

variable "files_producer_pods_name" {
  type = string
  default = "files-producer"
}

variable "files_producer_image" {
  type = string
  default = "ykbhlvck/files_producer:latest"
}

variable "files_producer_container_name" {
  type = string
  default = "files-producer"
}

variable "files_producer_port" {
  type = number
  default = 5000
}

variable "files_producer_config_map_name" {
  type = string
  default = "files-producer-config-map"
}