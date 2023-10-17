resource "kubernetes_service" "proxy_python_service" {
  metadata {
    name      = "proxy-python-service"
    namespace = var.kube_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.proxy_python_deployment.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}