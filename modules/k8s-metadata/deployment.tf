resource "kubernetes_deployment" "metadata_deployment" {
  metadata {
    name = "metadata-deployment"
    labels = {
      app = "metadata"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "metadata"
      }
    }

    template {
      metadata {
        labels = {
          app = "metadata"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/metadata-scala:latest"
          image_pull_policy = "Always"
          name              = "metadata"

          env {
            name = "DATABASE_HOST"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.database_details.metadata.0.name
                key  = "postgres_host"
              }
            }
          }

          env {
            name = "DATABASE_PORT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.database_details.metadata.0.name
                key  = "postgres_port"
              }
            }
          }

          env {
            name = "DATABASE_NAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.database_details.metadata.0.name
                key  = "postgres_db"
              }
            }
          }

          env {
            name = "DATABASE_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.database_details.metadata.0.name
                key  = "postgres_user"
              }
            }
          }

          env {
            name = "DATABASE_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.database_details.metadata.0.name
                key  = "postgres_passw"
              }
            }
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}