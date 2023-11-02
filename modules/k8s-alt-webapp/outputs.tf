output "baseurl" {
  description = "Base URL for the service"
  value       = "http://${kubernetes_service.alt-webapp_service.metadata[0].name}:${kubernetes_service.alt-webapp_service.spec[0].port[0].port}/"
}