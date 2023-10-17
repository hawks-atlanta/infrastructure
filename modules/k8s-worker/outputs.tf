output "host" {
  description = "Host of the service"
  value       = kubernetes_service.worker_service.metadata[0].name
}

output "port" {
  description = "Port of the service"
  value       = kubernetes_service.worker_service.spec[0].port[0].port
}