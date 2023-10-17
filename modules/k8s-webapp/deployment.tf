resource "kubernetes_deployment" "webapp_deployment" {
  metadata {
    name = "webapp-deployment"
    labels = {
      app = "webapp"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/frontend-react:latest"
          image_pull_policy = "Always"
          name              = "webapp"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}