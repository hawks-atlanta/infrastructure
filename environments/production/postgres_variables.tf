variable "postgres_username" {
  description = "postgresql.username"
  type        = string
  default     = "postgres"
}

variable "postgres_password" {
  description = "postgresql.password"
  type        = string
}

variable "postgres_database" {
  description = "postgresql.database"
  type        = string
  default     = "capyfile"
}

variable "postgres_replica_count" {
  description = "postgresql.replicaCount"
  type        = number
  default     = 3
}