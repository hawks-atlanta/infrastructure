variable "kube_namespace" {
  description = "Namespace to deploy"
  type        = string
}

variable "replicas" {
  description = "Deployment initial replicas"
  type        = number
}

variable "metadata_baseurl" {
  description = "Metadata base URL"
  type        = string
}

variable "original_1" {
  description = "Original 1 persistence name"
  type        = string
}

variable "backups_1" {
  description = "Backups 1 persistence name"
  type        = string
}

locals {
  volume_basepath = "/var/capy/store"
}