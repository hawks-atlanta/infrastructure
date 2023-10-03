variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "replicas" {
  description = "Deployment initial replicas"
  type        = number
}

variable "authentication_baseurl" {
  description = "Authentication base url"
  type        = string
}

variable "metadata_baseurl" {
  description = "Metadata base url"
  type        = string
}

variable "worker_host" {
  description = "Worker Host"
  type        = string
}

variable "worker_port" {
  description = "Worker port"
  type        = number
}