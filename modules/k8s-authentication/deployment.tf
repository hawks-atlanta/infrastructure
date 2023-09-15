resource "kubernetes_deployment" "authentication_deployment" {
  timeouts {
    create = "3m"
    update = "3m"
    delete = "3m"
  }
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
          image = "ghcr.io/hawks-atlanta/authentication-go:latest"
          name  = "authentication"

          env {
            name  = "POSTGRES_DSN"
            value = var.postgres_dsn
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}