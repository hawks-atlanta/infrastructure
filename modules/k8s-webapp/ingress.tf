resource "kubernetes_manifest" "webapp_stripprefix_middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "webapp-stripprefix"
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

resource "kubernetes_ingress_v1" "webapp_ingress" {
  metadata {
    name      = "webapp-ingress"
    namespace = var.kube_namespace

    annotations = {
      "traefik.ingress.kubernetes.io/router.middlewares" = "${var.kube_namespace}-webapp-stripprefix@kubernetescrd"
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
              name = kubernetes_service.webapp_service.metadata[0].name
              port {
                number = 80
              }
            }
          }

          path      = "/"
          path_type = "Prefix"
        }
      }
    }
  }
}