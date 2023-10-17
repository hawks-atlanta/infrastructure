resource "kubernetes_service" "webapp_service" {
  metadata {
    name      = "webapp-service"
    namespace = var.kube_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.webapp_deployment.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}