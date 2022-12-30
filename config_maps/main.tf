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

output "zookeeper_config_map_name" {
  value = kubernetes_config_map_v1.zookeeper_config_map.metadata.0.name
}

output "zookeeper_port" {
  value = tonumber(kubernetes_config_map_v1.zookeeper_config_map.data["ZOOKEEPER_CLIENT_PORT"])
}