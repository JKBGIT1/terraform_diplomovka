variable "diplomovka_namespace_name" {
  type = string
  default = "diplomovka"
}

resource "kubernetes_secret_v1" "minio_secrets" {
  metadata {
    name = "minio-secrets"
    namespace = var.diplomovka_namespace_name
  }

  # source: https://github.com/hashicorp/terraform-provider-kubernetes/issues/889
  data = {
    for line in compact(split("\r\n", file("./secrets/minio_credentials.env"))):
      split("=",line)[0] => split("=",line)[1]
  }
}

resource "kubernetes_secret_v1" "postgres_secret" {
  metadata {
    name = "postgres-secrets"
    namespace = var.diplomovka_namespace_name
  }

  # TODO: create function for env parse or find out better way how to load env files to k8s secrets
  # source: https://github.com/hashicorp/terraform-provider-kubernetes/issues/889
  data = {
    for line in compact(split("\r\n", file("./secrets/postgres_credentials.env"))):
      split("=",line)[0] => split("=",line)[1]
  }
}

output "minio_secret_name" {
  value = kubernetes_secret_v1.minio_secrets.metadata.0.name
}

output "postgres_secret_name" {
  value = kubernetes_secret_v1.postgres_secret.metadata.0.name
}