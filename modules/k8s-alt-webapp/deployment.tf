resource "kubernetes_deployment" "alt-webapp_deployment" {
  metadata {
    name = "alt-webapp-deployment"
    labels = {
      app = "alt-webapp"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "alt-webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "alt-webapp"
        }
      }

      spec {
        container {
          image             = "ghcr.io/pedrochaparro/alternative-frontend-react:latest"
          image_pull_policy = "Always"
          name              = "alt-webapp"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}