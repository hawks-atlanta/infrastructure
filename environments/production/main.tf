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

# NFS
module "helm_nfs" {
  source         = "../../modules/helm-nfs"
  kube_namespace = var.kube_namespace
}

module "k8s_worker" {
  source         = "../../modules/k8s-worker"
  kube_namespace = var.kube_namespace

  # Variables
  replicas     = var.worker_replicas
  metadata_baseurl = module.k8s_metadata.baseurl

  # Volumes
  original_1 = module.helm_nfs.original_1
  backups_1  = module.helm_nfs.backup_1

  depends_on = [
    module.helm_nfs
  ]
}

module "k8s_authentication" {
  source         = "../../modules/k8s-authentication"
  kube_namespace = var.kube_namespace

  # Variables
  replicas     = var.authentication_replicas
  postgres_dsn = local.authentication_postgres_dsn

  depends_on = [
    module.helm_postgres
  ]
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

  depends_on = [
    module.helm_postgres
  ]
}