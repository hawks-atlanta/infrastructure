# Postgres
module "helm_authentication_postgres" {
  source         = "../../modules/helm-postgres"
  kube_namespace = var.kube_namespace

  # Variables
  name_override = "authentication"
  username      = var.postgres_username
  password      = var.postgres_password
  database      = var.postgres_database
  replica_count = var.postgres_replica_count
}

module "helm_metadata_postgres" {
  source         = "../../modules/helm-postgres"
  kube_namespace = var.kube_namespace

  # Variables
  name_override = "metadata"
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
  replicas         = var.worker_replicas
  metadata_baseurl = module.k8s_metadata.baseurl

  # Volumes
  original_1 = module.helm_nfs.original_1
  backups_1  = module.helm_nfs.backup_1

  depends_on = [
    module.helm_nfs,
    module.k8s_metadata
  ]
}

module "k8s_authentication" {
  source         = "../../modules/k8s-authentication"
  kube_namespace = var.kube_namespace

  # Variables
  replicas     = var.authentication_replicas
  postgres_dsn = "host=${module.helm_authentication_postgres.host} user=${var.postgres_username} password=${var.postgres_password} dbname=${var.postgres_database} port=${module.helm_authentication_postgres.port} sslmode=disable"

  depends_on = [
    module.helm_authentication_postgres
  ]
}

module "k8s_metadata" {
  source         = "../../modules/k8s-metadata"
  kube_namespace = var.kube_namespace

  # Variables
  replicas       = var.metadata_replicas
  postgres_host  = module.helm_metadata_postgres.host
  postgres_port  = module.helm_metadata_postgres.port
  postgres_db    = var.postgres_database
  postgres_user  = var.postgres_username
  postgres_passw = var.postgres_password

  depends_on = [
    module.helm_metadata_postgres
  ]
}

module "k8s_gateway" {
  source         = "../../modules/k8s-gateway"
  kube_namespace = var.kube_namespace

  # Variables
  replicas               = var.gateway_replicas
  authentication_baseurl = module.k8s_authentication.baseurl
  metadata_baseurl       = module.k8s_metadata.baseurl
  worker_host            = module.k8s_worker.host
  worker_port            = module.k8s_worker.port

  depends_on = [
    module.k8s_worker,
    module.k8s_authentication,
    module.k8s_metadata
  ]
}

module "k8s_adminer" {
  source         = "../../modules/k8s-adminer"
  kube_namespace = var.kube_namespace

  # Variables
  replicas         = 1
}