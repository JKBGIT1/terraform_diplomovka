variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

variable "host_name" {
  type = string
  default = "localhost"
}

variable "minio_ingress_name" {
  type = string
  default = "minio-ingress"
}

variable "minio_gui_service_name" {
  type = string
  default = "minio-gui"
}

variable "minio_gui_port" {
  type = number
  default = 9001
}

variable "files_producer_ingress_name" {
  type = string
  default = "files-producer-ingress"
}

variable "files_producer_path" {
  type = string
  default = "/"
}

variable "files_producer_service_name" {
  type = string
  default = "files-producer"
}

variable "files_producer_port" {
  type = number
  default = 5000
}