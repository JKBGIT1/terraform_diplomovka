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
    for line in compact(split("\n", file("./secrets/minio_credentials.env"))):
      split("=",line)[0] => split("=",line)[1]
  }
}

output "minio_secret_name" {
  value = kubernetes_secret_v1.minio_secrets.metadata.0.name
}