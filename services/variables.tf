variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "minio_pods_name" {
  type = string
  default = "minio"
}

variable "minio_api_service_name" {
  type = string
  default = "minio-api"
}

variable "minio_api_port" {
  type = number
  default = 9000
}

variable "minio_gui_port" {
  type = number
  default = 9001
}

variable "minio_gui_service_name" {
  type = string
  default = "minio-gui"
}

variable "zookeeper_pods_name" {
  type = string
  default = "zookeeper"
}

variable "zookeeper_service_name" {
  type = string
  default = "zookeeper"
}

variable "zookeeper_port" {
  type = number
  default = 2181
}

variable "broker_service_name" {
  type = string
  default = "broker"
}

variable "broker_pods_name" {
  type = string
  default = "broker"
}

variable "broker_port" {
  type = number
  default = 29092
}

variable "schema_registry_service_name" {
  type = string
  default = "registry"
}

variable "schema_registry_pods_name" {
  type = string
  default = "registry"
}

variable "schema_registry_port" {
  type = number
  default = 8081
}

variable "redis_service_name" {
  type = string
  default = "redis"
}

variable "redis_pods_name" {
  type = string
  default = "redis"
}

variable "redis_port" {
  type = number
  default = 6379
}

variable "files_producer_service_name" {
  type = string
  default = "files-producer"
}

variable "files_producer_pods_name" {
  type = string
  default = "files-producer"
}

variable "files_producer_port" {
  type = number
  default = 5000
}