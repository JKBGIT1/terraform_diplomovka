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