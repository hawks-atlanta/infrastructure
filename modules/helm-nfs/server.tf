resource "helm_release" "nfs_server" {
  name       = "nfs-server"
  repository = "https://charts.helm.sh/stable"
  chart      = "nfs-server-provisioner"
  namespace  = var.kube_namespace

  set {
    name  = "persistence.size"
    value = var.persistence_size
  }
}