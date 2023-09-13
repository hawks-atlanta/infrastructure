# Kubernetes
provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.kube_namespace
  }
}