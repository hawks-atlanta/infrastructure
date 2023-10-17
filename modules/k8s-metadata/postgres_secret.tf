resource "kubernetes_secret" "database_details" {
  metadata {
    name      = "metadata-database-details"
    namespace = var.kube_namespace
  }

  data = {
    postgres_host  = var.postgres_host
    postgres_port  = var.postgres_port
    postgres_db    = var.postgres_db
    postgres_user  = var.postgres_user
    postgres_passw = var.postgres_passw
  }

  type = "Opaque"
}
