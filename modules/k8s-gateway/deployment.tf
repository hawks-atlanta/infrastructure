resource "kubernetes_deployment" "gateway_deployment" {
  metadata {
    name = "gateway-deployment"
    labels = {
      app = "gateway"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "gateway"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/gateway-java:latest"
          image_pull_policy = "Always"
          name              = "gateway"

          env {
            name  = "AUTHENTICATION_BASEURL"
            value = var.authentication_baseurl
          }

          env {
            name  = "METADATA_BASEURL"
            value = var.metadata_baseurl
          }

          env {
            name  = "WORKER_HOST"
            value = var.worker_host
          }

          env {
            name  = "WORKER_PORT"
            value = var.worker_port
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}