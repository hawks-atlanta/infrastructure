resource "kubernetes_deployment" "example" {
  metadata {
    name = "example-deployment"
    labels = {
      App = "example-app"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        App = "example-app"
      }
    }

    template {
      metadata {
        labels = {
          App = "example-app"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "example-container"

          volume_mount {
            name       = "my-vol"
            mount_path = "/data"
          }
        }

        volume {
          name = "my-vol"

          persistent_volume_claim {
            claim_name = var.original_1
          }
        }
      }
    }
  }
}