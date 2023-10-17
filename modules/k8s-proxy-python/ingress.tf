resource "kubernetes_manifest" "proxy_python_stripprefix_middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "proxy-python-stripprefix"
      "namespace" = var.kube_namespace
    }
    "spec" = {
      "stripPrefix" = {
        "prefixes"   = ["/api/python"]
        "forceSlash" = false
      }
    }
  }
}

resource "kubernetes_ingress_v1" "proxy_python_ingress" {
  metadata {
    name      = "proxy-python-ingress"
    namespace = var.kube_namespace

    annotations = {
      "traefik.ingress.kubernetes.io/router.middlewares" = "${var.kube_namespace}-proxy-python-stripprefix@kubernetescrd"
      "kubernetes.io/ingress.class" = "traefik"
    }
  }

  spec {
    ingress_class_name = "traefik"
    rule {
      host = "capyfile1.bucaramanga.upb.edu.co"
      http {
        path {
          backend {
            service {
              name = kubernetes_service.proxy_python_service.metadata[0].name
              port {
                number = 8080
              }
            }
          }

          path      = "/api/python"
          path_type = "Prefix"
        }
      }
    }
  }
}