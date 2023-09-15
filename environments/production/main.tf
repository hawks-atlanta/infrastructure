# Postgres
module "helm_postgres" {
  source         = "../../modules/helm-postgres"
  kube_namespace = var.kube_namespace

  # Variables
  username      = var.postgres_username
  password      = var.postgres_password
  database      = var.postgres_database
  replica_count = var.postgres_replica_count
}

module "k8s_authentication" {
  source         = "../../modules/k8s-authentication"
  kube_namespace = var.kube_namespace

  # Variables
  replicas     = var.authentication_replicas
  postgres_dsn = local.authentication_postgres_dsn
}

module "k8s_metadata" {
  source         = "../../modules/k8s-metadata"
  kube_namespace = var.kube_namespace

  # Variables
  replicas       = var.metadata_replicas
  postgres_host  = local.metadata_postgres_host
  postgres_port  = local.metadata_postgres_port
  postgres_db    = var.postgres_database
  postgres_user  = var.postgres_username
  postgres_passw = var.postgres_password
}