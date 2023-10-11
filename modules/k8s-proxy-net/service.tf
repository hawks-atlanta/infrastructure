resource "kubernetes_service" "proxy_net_service" {
  metadata {
    name      = "proxy-net-service"
    namespace = var.kube_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.proxy_net_deployment.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}