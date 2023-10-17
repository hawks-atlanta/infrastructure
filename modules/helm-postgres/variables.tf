variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "name_override" {
  description = "nameOverride"
  type        = string
}

variable "username" {
  description = "postgresql.username"
  type        = string
}

variable "password" {
  description = "postgresql.password"
  type        = string
}

variable "database" {
  description = "postgres_database"
  type        = string
}

variable "replica_count" {
  description = "postgresql.replicaCount"
  type        = number
}