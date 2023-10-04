output "baseurl" {
  description = "Base URL for the service"
  value       = "http://${kubernetes_service.metadata_service.metadata[0].name}:${kubernetes_service.metadata_service.spec[0].port[0].port}/api/v1"
}