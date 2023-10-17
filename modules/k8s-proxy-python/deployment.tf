resource "kubernetes_deployment" "proxy_python_deployment" {
  metadata {
    name = "proxy-python-deployment"
    labels = {
      app = "proxy-python"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "proxy-python"
      }
    }

    template {
      metadata {
        labels = {
          app = "proxy-python"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/proxy-python:latest"
          image_pull_policy = "Always"
          name              = "proxy-python"

          env {
            name  = "GATEWAY_BASEURL"
            value = var.gateway_baseurl
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}