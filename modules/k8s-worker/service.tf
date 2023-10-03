resource "kubernetes_service" "worker_service" {
  metadata {
    name      = "worker-service"
    namespace = var.kube_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.worker_deployment.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}