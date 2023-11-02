variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "replicas" {
  description = "Deployment initial replicas"
  type        = number
}
