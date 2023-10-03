variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
}