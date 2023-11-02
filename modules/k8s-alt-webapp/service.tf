resource "kubernetes_service" "alt-webapp_service" {
  metadata {
    name      = "alt-webapp-service"
    namespace = var.kube_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.alt-webapp_deployment.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}