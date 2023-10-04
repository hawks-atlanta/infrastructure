resource "kubernetes_ingress_v1" "gateway_ingress" {
  metadata {
    name      = "gateway-ingress"
    namespace = var.kube_namespace

    annotations = {
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
              name = kubernetes_service.gateway_service.metadata[0].name
              port {
                number = 8080
              }
            }
          }

          #path      = "/gw/service" # TODO: Include me
          path      = "/service"
          path_type = "Prefix"
        }
      }
    }
  }
}