variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

resource "kubernetes_config_map_v1" "zookeeper_config_map" {
  metadata {
    name = "zookeeper-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/kafka_zookeeper.env")))):
      tostring(split("=",line)[0]) => tostring(split("=",line)[1])
  }
}

resource "kubernetes_config_map_v1" "broker_config_map" {
  metadata {
    name = "broker-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/kafka_broker.env")))):
      split("=",line)[0] => split("=",line)[1]
  }
}

resource "kubernetes_config_map_v1" "schema_registry_config_map" {
  metadata {
    name = "schema-registry-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/kafka_schema_registry.env")))):
      split("=",line)[0] => split("=",line)[1]
  }
}

resource "kubernetes_config_map_v1" "files_consumer_config_map" {
  metadata {
    name = "files-consumer-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/files_consumer.env")))):
      split("=",line)[0] => split("=",line)[1]
  }
}

resource "kubernetes_config_map_v1" "files_producer_config_map" {
  metadata {
    name = "files-producer-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/files_producer.env")))):
      split("=",line)[0] => split("=",line)[1]
  }
}

resource "kubernetes_config_map_v1" "structured_data_consumer_config_map" {
  metadata {
    name = "structured-data-consumer-config-map"
    namespace = var.diplomovka_namespace_name
  }
  data = {
    for line in compact(split("\r\n", trimspace(file("./config_maps/structured_data_consumer.env")))):
      split("=",line)[0] => split("=",line)[1]
  }
}

output "zookeeper_config_map_name" {
  value = kubernetes_config_map_v1.zookeeper_config_map.metadata.0.name
}

output "zookeeper_port" {
  value = tonumber(kubernetes_config_map_v1.zookeeper_config_map.data["ZOOKEEPER_CLIENT_PORT"])
}

output "broker_config_map_name" {
  value = kubernetes_config_map_v1.broker_config_map.metadata.0.name
}

output "broker_port" {
  value = tonumber(kubernetes_config_map_v1.broker_config_map.data["BROKER_PORT"])
}

output "schema_registry_config_map_name" {
  value = kubernetes_config_map_v1.schema_registry_config_map.metadata.0.name
}

output "schema_registry_port" {
  value = tonumber(kubernetes_config_map_v1.schema_registry_config_map.data["PORT"])
}

output "files_consumer_config_map_name" {
  value = kubernetes_config_map_v1.files_consumer_config_map.metadata.0.name
}

output "files_producer_config_map_name" {
  value = kubernetes_config_map_v1.files_producer_config_map.metadata.0.name
}

output "structured_data_consumer_config_map_name" {
  value = kubernetes_config_map_v1.structured_data_consumer_config_map.metadata.0.name
}