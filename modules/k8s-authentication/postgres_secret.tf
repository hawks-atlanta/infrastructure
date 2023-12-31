resource "kubernetes_secret" "postgres_dsn" {
  metadata {
    name      = "authentication-postgres-dsn"
    namespace = var.kube_namespace
  }

  data = {
    postgres_dsn_value = var.postgres_dsn
  }

  type = "Opaque"
}
