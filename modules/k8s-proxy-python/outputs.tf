output "baseurl" {
  description = "Base URL for the service"
  value       = "http://${kubernetes_service.proxy_python_service.metadata[0].name}:${kubernetes_service.proxy_python_service.spec[0].port[0].port}/"
}