resource "helm_release" "postgresql-ha" {
  name       = "postgresql-ha-${var.name_override}"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql-ha"
  namespace  = var.kube_namespace

  # Protect it from destroy command
  lifecycle {
    #prevent_destroy = true # var.prevent_destroy TODO: 
  }

  # Variables
  set {
    name = "nameOverride"
    value = var.name_override
  }
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