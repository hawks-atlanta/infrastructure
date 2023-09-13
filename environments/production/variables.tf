# Kubernetes cluster
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
}

variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
  default     = "capyfile-production"
}