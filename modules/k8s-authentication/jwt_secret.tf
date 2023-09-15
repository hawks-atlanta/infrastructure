resource "random_string" "jwt_secret" {
  length  = 32
  special = false
}

resource "kubernetes_secret" "jwt_secret" {
  metadata {
    name      = "authentication-jwt-secret"
    namespace = var.kube_namespace
  }

  data = {
    jwt_secret_value = random_string.jwt_secret.result
  }

  type = "Opaque"
}
