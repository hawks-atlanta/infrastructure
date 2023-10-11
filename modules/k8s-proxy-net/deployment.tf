//ASPNETCORE_URLS=http://+:8080

resource "kubernetes_deployment" "proxy_net_deployment" {
  metadata {
    name = "proxy-net-deployment"
    labels = {
      app = "proxy-net"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "proxy-net"
      }
    }

    template {
      metadata {
        labels = {
          app = "proxy-net"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/proxy-net:latest"
          image_pull_policy = "Always"
          name              = "proxy-net"

          env {
            name  = "SERVICE_URL"
            value = var.gateway_baseurl
          }

          env {
            name  = "ASPNETCORE_URLS"
            value = "http://0.0.0.0:8080"
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}