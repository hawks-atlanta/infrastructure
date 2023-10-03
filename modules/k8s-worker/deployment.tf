resource "kubernetes_deployment" "worker_deployment" {
  metadata {
    name = "worker-deployment"
    labels = {
      app = "worker"
    }
    namespace = var.kube_namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "worker"
      }
    }

    template {
      metadata {
        labels = {
          app = "worker"
        }
      }

      spec {
        container {
          image             = "ghcr.io/hawks-atlanta/worker-java:latest"
          image_pull_policy = "Always"
          name              = "worker"

          volume_mount {
            name       = "volume-1"
            mount_path = "${local.volume_basepath}/file/volume1"
          }

          volume_mount {
            name       = "backup-1"
            mount_path = "${local.volume_basepath}/backups/volume1"
          }

          env {
            name  = "METADATA_BASEURL"
            value = var.metadata_baseurl
          }

          env {
            name  = "VOLUME_BASE_PATH"
            value = local.volume_basepath
          }

          env {
            name  = "AVAILABLE_VOLUMES"
            value = "1"
          }

          port {
            container_port = 1099
          }
        }

        volume {
          name = "volume-1"

          persistent_volume_claim {
            claim_name = var.original_1
          }
        }
        volume {
          name = "backup-1"

          persistent_volume_claim {
            claim_name = var.backups_1
          }
        }
      }
    }
  }
}