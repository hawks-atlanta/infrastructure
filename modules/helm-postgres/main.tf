resource "helm_release" "postgresql-ha" {
  name       = "postgresql-ha"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql-ha"
  namespace  = var.kube_namespace

  # Protect it from destroy command
  lifecycle {
    # TODO: FIXME: prevent_destroy = var.prevent_destroy
  }

  # Variables
  set {
    name  = "postgresql.username"
    value = var.username
  }
  set {
    name  = "postgresql.password"
    value = var.password
  }
  set {
    name  = "postgresql.database"
    value = var.database
  }
  set {
    name  = "postgresql.replicaCount"
    value = tostring(var.replica_count)
  }
}