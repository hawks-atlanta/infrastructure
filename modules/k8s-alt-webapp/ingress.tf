resource "kubernetes_manifest" "alt-webapp_stripprefix_middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "alt-webapp-stripprefix"
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

resource "kubernetes_ingress_v1" "alt-webapp_ingress" {
  metadata {
    name      = "alt-webapp-ingress"
    namespace = var.kube_namespace

    annotations = {
      "traefik.ingress.kubernetes.io/router.middlewares" = "${var.kube_namespace}-alt-webapp-stripprefix@kubernetescrd"
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
              name = kubernetes_service.alt-webapp_service.metadata[0].name
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