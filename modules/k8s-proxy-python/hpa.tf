resource "kubernetes_horizontal_pod_autoscaler" "proxy-python-hpa" {
  metadata {
    name      = "proxy-python-hpa"
    namespace = var.kube_namespace
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "proxy-python-deployment"
    }
    min_replicas                      = 1
    max_replicas                      = 50
    target_cpu_utilization_percentage = 50
  }
}