
resource "kubernetes_manifest" "stripprefix_middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "stripprefix"
      "namespace" = var.kube_namespace
    }
    "spec" = {
      "stripPrefix" = {
        "prefixes"   = ["/"]
        "forceSlash" = false
      }
    }
  }
}

resource "kubernetes_ingress_v1" "gateway_ingress" {
  metadata {
    name      = "gateway-ingress"
    namespace = var.kube_namespace

    annotations = {
      # "traefik.ingress.kubernetes.io/router.middlewares" = "${var.kube_namespace}-stripprefix@kubernetescrd"
      "kubernetes.io/ingress.class"                      = "traefik"
    }
  }

  spec {
    ingress_class_name = "traefik"
    rule {
      http {
        path {
          backend {
            service {
              name   = kubernetes_service.gateway_service.metadata[0].name
              port {
                number = 8080
              }
            }
          }

          path      = "/gw/service"
          path_type = "Prefix"
        }
      }
    }
  }
}