resource "kubernetes_persistent_volume_claim" "original_1" {
  depends_on = [helm_release.nfs_server]
  metadata {
    name      = "original-1"
    namespace = var.kube_namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "5Gi"
      }
    }

    storage_class_name = "nfs"
  }
}

resource "kubernetes_persistent_volume_claim" "backup_1" {
  depends_on = [helm_release.nfs_server]
  metadata {
    name      = "backup-1"
    namespace = var.kube_namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "5Gi"
      }
    }

    storage_class_name = "nfs"
  }
}

output "original_1" {
  description = "Volume 1 (original) name"
  value = kubernetes_persistent_volume_claim.original_1.metadata[0].name
}

output "backup_1" {
  description = "Volume 1 (backups) name"
  value = kubernetes_persistent_volume_claim.backup_1.metadata[0].name
}