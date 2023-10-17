resource "kubernetes_deployment" "adminer_deployment" {
  metadata {
    name = "adminer-deployment"
    labels = {
      app = "adminer"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "adminer"
      }
    }

    template {
      metadata {
        labels = {
          app = "adminer"
        }
      }

      spec {
        container {
          image             = "adminer:latest"
          image_pull_policy = "Always"
          name              = "adminer"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}