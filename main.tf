terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "docker-desktop"
}

module "my_namespaces" {
  source = "./namespaces"
}

module "my_secrets" {
  source = "./secrets"

  diplomovka_namespace_name = module.my_namespaces.namespace_name

  depends_on = [
    module.my_namespaces
  ]
}

module "my_config_maps" {
  source = "./config_maps"

  diplomovka_namespace_name = module.my_namespaces.namespace_name

  depends_on = [
    module.my_namespaces
  ]
}

module "my_persistent_volumes" {
  source = "./persistent_volumes"
  depends_on = [
    module.my_namespaces
  ]
}

module "my_persistent_volume_claims" {
  source = "./persistent_volume_claims"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  minio_pv_name = module.my_persistent_volumes.minio_pv_name
  redis_pv_name = module.my_persistent_volumes.redis_pv_name
  postgres_pv_name = module.my_persistent_volumes.postgres_pv_name

  depends_on = [
    module.my_persistent_volumes
  ]
}

module "my_deployments" {
  source = "./deployments"

  diplomovka_namespace_name = module.my_namespaces.namespace_name

  minio_pv_name = module.my_persistent_volumes.minio_pv_name
  minio_pvc_name = module.my_persistent_volume_claims.minio_pvc_name
  minio_secret_name = module.my_secrets.minio_secret_name

  redis_pv_name = module.my_persistent_volumes.redis_pv_name
  redis_pvc_name = module.my_persistent_volume_claims.redis_pvc_name

  postgres_pv_name = module.my_persistent_volumes.postgres_pv_name
  postgres_pvc_name = module.my_persistent_volume_claims.postgres_pvc_name
  postgres_secret_name = module.my_secrets.postgres_secret_name

  zookeeper_config_map_name = module.my_config_maps.zookeeper_config_map_name
  zookeeper_port = module.my_config_maps.zookeeper_port

  broker_config_map_name = module.my_config_maps.broker_config_map_name
  broker_port = module.my_config_maps.broker_port

  schema_registry_config_map_name = module.my_config_maps.schema_registry_config_map_name
  schema_registry_port = module.my_config_maps.schema_registry_port

  files_consumer_config_map_name = module.my_config_maps.files_consumer_config_map_name

  files_producer_config_map_name = module.my_config_maps.files_producer_config_map_name

  structured_data_consumer_config_map_name = module.my_config_maps.structured_data_consumer_config_map_name
  structured_data_producer_config_map_name = module.my_config_maps.structured_data_producer_config_map_name

  depends_on = [
    module.my_persistent_volume_claims,
    module.my_secrets,
    module.my_config_maps
  ]
}

module "my_services" {
  source = "./services"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  minio_pods_name = module.my_deployments.minio_pods_name

  zookeeper_pods_name = module.my_deployments.zookeeper_pods_name
  zookeeper_port = module.my_config_maps.zookeeper_port

  broker_pods_name = module.my_deployments.broker_pods_name
  broker_port = module.my_config_maps.broker_port

  schema_registry_pods_name = module.my_deployments.schema_registry_pods_name
  schema_registry_port = module.my_config_maps.schema_registry_port

  redis_pods_name = module.my_deployments.redis_pods_name

  files_producer_pods_name = module.my_deployments.files_producer_pods_name

  postgres_pods_name = module.my_deployments.postgres_pods_name

  structured_data_producer_pods_name = module.my_deployments.structured_data_producer_pods_name

  depends_on = [
    module.my_deployments
  ]
}

module "my_ingress" {
  source = "./ingress"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  minio_gui_service_name = module.my_services.minio_gui_service_name

  files_producer_service_name = module.my_services.files_producer_service_name

  depends_on = [
    module.my_services
  ]
}