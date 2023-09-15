variable "metadata_replicas" {
  description = "Replicas to initialy deploy"
  type        = string
  default     = 1
}

locals {
  metadata_postgres_host = "postgresql-ha-pgpool"
  metadata_postgres_port = "5432"
}