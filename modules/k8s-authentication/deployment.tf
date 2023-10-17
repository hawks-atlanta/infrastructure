resource "kubernetes_deployment" "authentication_deployment" {
  metadata {
    name = "authentication-deployment"
    labels = {
      app = "authentication"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "authentication"
      }
    }

    template {
      metadata {
        labels = {
          app = "authentication"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/authentication-go:latest"
          image_pull_policy = "Always"
          name              = "authentication"

          env {
            name  = "DATABASE_ENGINE"
            value = "postgres"
          }

          env {
            name = "DATABASE_DSN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.postgres_dsn.metadata.0.name
                key  = "postgres_dsn_value"
              }
            }
          }

          env {
            name = "JWT_SECRET"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.jwt_secret.metadata.0.name
                key  = "jwt_secret_value"
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