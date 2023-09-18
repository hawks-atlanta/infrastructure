variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "persistence_size" {
  description = "Persistence size"
  type        = string
  default     = "20Gi"
}