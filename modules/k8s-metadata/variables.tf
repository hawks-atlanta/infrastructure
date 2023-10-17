variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "replicas" {
  description = "Deployment initial replicas"
  type        = number
}

variable "postgres_host" {
  description = "Postgres HOST"
  type        = string
}

variable "postgres_port" {
  description = "Postgres PORT"
  type        = string
}

variable "postgres_db" {
  description = "Postgres DATABASE"
  type        = string
}

variable "postgres_user" {
  description = "Postgres username"
  type        = string
}

variable "postgres_passw" {
  description = "Postgres password"
  type        = string
}