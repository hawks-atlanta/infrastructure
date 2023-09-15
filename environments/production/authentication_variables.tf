variable "authentication_replicas" {
  description = "Replicas to initialy deploy"
  type        = string
  default     = 1
}

locals {
  authentication_postgres_dsn     = "host=postgresql-ha-pgpool user=${var.postgres_username} password=${var.postgres_password} dbname=${var.postgres_database} port=5432 sslmode=disable"
}