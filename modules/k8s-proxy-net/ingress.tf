resource "kubernetes_manifest" "proxy_net_stripprefix_middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "proxy-net-stripprefix"
      "namespace" = var.kube_namespace
    }
    "spec" = {
      "stripPrefix" = {
        "prefixes"   = ["/api/net"]
        "forceSlash" = false
      }
    }
  }
}

resource "kubernetes_ingress_v1" "proxy_net_ingress" {
  metadata {
    name      = "proxy-net-ingress"
    namespace = var.kube_namespace

    annotations = {
      "traefik.ingress.kubernetes.io/router.middlewares" = "${var.kube_namespace}-proxy-net-stripprefix@kubernetescrd"
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
              name = kubernetes_service.proxy_net_service.metadata[0].name
              port {
                number = 8080
              }
            }
          }

          path      = "/api/net"
          path_type = "Prefix"
        }
      }
    }
  }
}