output "baseurl" {
  description = "Base URL for the service"
  value       = "http://${kubernetes_service.gateway_service.metadata[0].name}:${kubernetes_service.gateway_service.spec[0].port[0].port}/gw/service"
}