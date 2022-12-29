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

  depends_on = [
    module.my_persistent_volumes
  ]
}

module "my_deployments" {
  source = "./deployments"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  persistent_volume_claim_name = module.my_persistent_volume_claims.minio_pvc_name
  minio_secret_name = module.my_secrets.minio_secret_name

  depends_on = [
    module.my_persistent_volume_claims,
    module.my_secrets
  ]
}

module "my-services" {
  source = "./services"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  pods_name = module.my_deployments.pods_name

  depends_on = [
    module.my_deployments
  ]
}

module "my-ingress" {
  source = "./ingress"

  diplomovka_namespace_name = module.my_namespaces.namespace_name
  service_name = module.my-services.service_name

  depends_on = [
    module.my-services
  ]
}